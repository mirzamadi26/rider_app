import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../view/authentication/otp_verification.dart';
import '../view/authentication/profile_name_screen.dart';
import '../view/authentication/welcome_screen.dart';
import '../view/home/home_screen.dart';
import '../widgets/progress_dialog.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  //Google Signin
  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      print("Successfully created");

      return await FirebaseAuth.instance.signInWithCredential(credential);
      // .then((value) => {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: ((context) => ProfileNameScreen())))
      //     });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  otpVerificaion(String number, BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        WelcomeScreen.verify = verificationId;
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => OTPVerification())));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> saveUserData(UserModel user) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final uid = currentUser.uid;
      final userDoc = await _usersCollection.doc(uid).get();
      if (userDoc.exists) {
        MaterialPageRoute(builder: ((context) => HomeScreen()));
      } else {
        MaterialPageRoute(builder: ((context) => ProfileNameScreen()));
        await _usersCollection.doc(uid).set(user.toJson());
      }
    }
  }

  Future<void> updateLoggedInStatus(bool isLoggedin) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final uid = currentUser.uid;
      await _usersCollection.doc(uid).update({'isLoggedin': isLoggedin});
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future<bool> checkUserExists() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final uid = currentUser.uid;

      final userDoc = await _usersCollection.doc(uid).get();
      return userDoc.exists;
    }

    return false;
  }
}
