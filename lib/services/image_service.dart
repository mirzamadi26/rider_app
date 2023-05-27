import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageService {
  static Future<File?> selectImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  static Future<String?> uploadImageToFirebase(
      File image, String userId) async {
    if (image == null) {
      return null;
    }
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref();
      final imageName = DateTime.now().microsecondsSinceEpoch.toString();
      final uploadTask =
          storageRef.child('profile_image/$userId/$imageName').putFile(image);
      final snapshot = await uploadTask.whenComplete(() {
        print('Image Uploaded');
      });
      if (snapshot.state == firebase_storage.TaskState.success) {
        final downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      print("Error: Uploading Image to Firebase");
    }
    return null;
  }

  static Future<String?> fetchProfileImageUrl(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final data = snapshot.data();
      if (data != null && data['profileImageUrl'] != null) {
        return data['profileImageUrl'];
      }
    } catch (e) {
      print('Error fetching profile Image: $e');
    }
    return null;
  }
}
