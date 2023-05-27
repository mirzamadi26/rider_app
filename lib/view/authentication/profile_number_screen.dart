import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/textfield_widget.dart';
import '../home/home_screen.dart';

class ProfileNumberScreen extends StatefulWidget {
  const ProfileNumberScreen({super.key});

  @override
  State<ProfileNumberScreen> createState() => _ProfileNumberScreenState();
}

class _ProfileNumberScreenState extends State<ProfileNumberScreen> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "What's your name?",
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
                TextFieldWidget(
                    controllerName: firstNameController,
                    klabelText: "First Name"),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    controllerName: lastNameController,
                    klabelText: "Last Name"),
              ],
            ),
            ButtonWidget(
                backgroundColor: AppColors.mainColor,
                text: "Continue",
                textColor: Colors.white,
                function: () async {
                  await authService.saveUserData(UserModel(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      mobileNumber: _auth.currentUser!.phoneNumber,
                      email: '',
                      authProvider: "Phone",
                      isLoggedin: true));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                })
          ],
        ),
      ),
    );
  }
}
