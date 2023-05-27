import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helpers/helperMethods.dart';
import '../model/directionDetails.dart';
import '../model/user_model.dart';
import '../provider/appdata.dart';

class DatabaseService {
  final User? user = FirebaseAuth.instance.currentUser;
  static Future<UserModel> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    final firstName = snapshot['firstName'].toString();
    final lastName = snapshot['lastName'].toString();

    return UserModel(firstName: firstName, lastName: lastName);
  }

  static Future<void> editProfile(String firstName, String lastName) async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  static Future<Map<String, dynamic>> getUserDetails() async {
    // Get the user's profile data from Firestore.
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (documentSnapshot.exists) {
      // Return the user's profile data.
      return documentSnapshot.data() as Map<String, dynamic>;
    }

    return {};
  }

  Future<void> updateUserData(Map<String, dynamic> userData) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update(userData);
  }

  CollectionReference rideRequestRef =
      FirebaseFirestore.instance.collection('rideRequest');

  String formattedDate = DateFormat.yMMMMEEEEd().format(DateTime.now());

  Future<String> createRideRequest(context) async {
    DocumentReference rideRef = rideRequestRef.doc();
    var pickUp = Provider.of<AppData>(context, listen: false).pickUpAddress;
    var destination =
        Provider.of<AppData>(context, listen: false).destinationAddress;
    Map<String, dynamic> pickUpMap = {
      'latitude': pickUp!.latitude.toString(),
      'longitude': pickUp.longitude.toString(),
    };
    Map<String, dynamic> destinationMap = {
      'latitude': destination!.latitude.toString(),
      'longitude': destination.longitude.toString(),
    };
    Map<String, dynamic> rideMap = {
      'userId': user!.uid,
      'created_at': formattedDate,
      'riderName': user!.displayName,
      'rider_phone': user!.phoneNumber,
      'pickUp_address': pickUp.placeName,
      'destination_address': destination.placeName,
      'location': pickUpMap,
      'destination': destinationMap,
      'payment_method': 'cash',
      'driver_id': 'waiting',
    };
    await rideRef.set(rideMap);
    return rideRef.id;
  }

  void cancelRideRequest(String rideRequestId) async {
    CollectionReference rideRequestRef =
        FirebaseFirestore.instance.collection('rideRequest');

    try {
      await rideRequestRef.doc(rideRequestId).delete();
      print('Ride Request deleted successfully');
    } catch (e) {
      print('Error deleting ride request: $e');
    }
  }

  // Replace with the actual user ID

  void fetchRideRequestId() {
    FirebaseFirestore.instance
        .collection('rideRequest')
        .where('userId', isEqualTo: user!.uid)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        String rideRequestId = querySnapshot.docs.first.id;
        // Now you have the rideRequestId, you can use it for deletion or any other operations
        cancelRideRequest(rideRequestId);
      }
    });
  }

  Future<void> completeRide(String userId) async {
    CollectionReference rideRequestRef =
        FirebaseFirestore.instance.collection('rideRequest');

    QuerySnapshot querySnapshot =
        await rideRequestRef.where('userId', isEqualTo: userId).get();

    if (querySnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot rideRequestDocument = querySnapshot.docs[0];
      String rideRequestId = rideRequestDocument.id;

      // Delete the document from rideRequest collection
      await rideRequestRef.doc(rideRequestId).delete();
      // Move the document to completedRides subcollection under users collection
      CollectionReference completedRidesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('completedRides');
      await completedRidesRef
          .doc(rideRequestId)
          .set(rideRequestDocument.data());
    } else {}
  }

  Future<List<Map<String, dynamic>>> getCompletedRides(String userId) async {
    List<Map<String, dynamic>> completedRides = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('completedRides')
        .get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> rideData = {
        'destination_address': doc.get('destination_address'),
        'created_at': doc.get('created_at'),
      };
      completedRides.add(rideData);
    });

    return completedRides;
  }

  void deleteUserAccount() async {
    try {
      if (user != null) {
        // Delete the user account
        await user!.delete();
        print('User account deleted successfully');
      } else {
        print('No user currently signed in');
      }
    } catch (e) {
      print('Failed to delete user account: $e');
    }
  }

  void deleteUserDataFromFirestore(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      print('User data deleted from Firestore successfully');
    } catch (e) {
      print('Failed to delete user data from Firestore: $e');
    }
  }
}
