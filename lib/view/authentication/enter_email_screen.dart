import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';

class EnterEmailScreen extends StatelessWidget {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  EnterEmailScreen({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter your email",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controllerName: _emailController,
                  klabelText: "Email",
                ),
                SizedBox(
                  height: 20,
                ),
                textWidget(
                    text: "We'll send you your trip receipts",
                    color: Colors.black54),
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
                      mobileNumber: auth.currentUser!.phoneNumber,
                      email: '',
                      authProvider: "Phone"));
                })
          ],
        ),
      ),
    );
  }
}
