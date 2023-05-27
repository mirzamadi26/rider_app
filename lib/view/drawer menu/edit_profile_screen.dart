import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import '../../services/database_service.dart';
import '../../services/image_service.dart';
import '../../utils/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/profile_widget.dart';

import '../../widgets/textfield_widget.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  File? _selectedImage;
  String? firstName;
  String? lastName;
  final DatabaseService _databaseService = DatabaseService();
  final User? user = FirebaseAuth.instance.currentUser;

  String? _profileImageUrl;
  void _selectImage() async {
    File? image = await ImageService.selectImageFromGallery();
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
      String? imageUrl =
          await ImageService.uploadImageToFirebase(_selectedImage!, user!.uid);
      if (imageUrl != null) {
        setState(() {
          _profileImageUrl = imageUrl;
        });
      }
    }
  }

  void _saveProfileData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      //User is not authenticated
      return;
    }
    final String userId = user.uid;
    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl =
          await ImageService.uploadImageToFirebase(_selectedImage!, userId);
      if (imageUrl == null) {
        return;
      }
    }

    firstName = firstNameController.text;

    lastName = lastNameController.text;
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final userData = {
        'firstName': firstName,
        'lastName': lastName,
      };
      if (imageUrl != null) {
        userData['profileImageUrl'] = imageUrl;
      }
      await userRef.update(userData);
      print("Updated Successfully");
    } catch (e) {
      print(e);
    }
  }

  void _fetchProfileImage(String userId) async {
    final imageUrl = await ImageService.fetchProfileImageUrl(userId);
    if (imageUrl != null) {
      setState(() {
        _profileImageUrl = imageUrl;
      });
    }
  }

  @override
  void initState() {
    if (user != null) {
      _fetchProfileImage(user!.uid);
      DatabaseService.getUserDetails().then((userDetails) {
        if (userDetails.isNotEmpty) {
          firstNameController.text = userDetails['firstName'];
          lastNameController.text = userDetails['lastName'];
        }
      });
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        backgroundColor: Colors.white38,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black54, size: 15),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Stack(alignment: Alignment.bottomCenter, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black45, width: 3),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!) as ImageProvider
                              : (_profileImageUrl != null
                                  ? NetworkImage(_profileImageUrl!)
                                  : null),
                          child:
                              _selectedImage == null && _profileImageUrl == null
                                  ? Icon(
                                      Icons.account_circle,
                                      size: 150,
                                    )
                                  : null,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _selectImage,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.edit,
                        size: 22,
                      ),
                      radius: 18,
                    ),
                  )
                ]),

                // ProfileWidget(
                //   imagePath: 'assets/profile.jpg',
                //   isEdit: true,
                //   onClicked: () {
                //     _selectImage();
                //   },
                // ),
                SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  controllerName: firstNameController,
                  klabelText: "First Name",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  controllerName: lastNameController,
                  klabelText: "Last Name",
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            ButtonWidget(
                backgroundColor: AppColors.mainColor,
                text: "Save",
                textColor: Colors.white,
                function: () async {
                  _saveProfileData();
                  await DatabaseService.editProfile(
                          firstNameController.text, lastNameController.text)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile updated successfully!')),
                    );
                  });
                })
          ],
        ),
      ),
    );
  }

  Future<void> saveChanges() async {
    final userData = {
      'firstName': firstName,
      'lastName': lastName,
    };

    await _databaseService.updateUserData(userData);
  }
}
