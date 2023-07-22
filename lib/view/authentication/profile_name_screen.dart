import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/progress_dialog.dart';
import '../../widgets/textfield_widget.dart';
import '../home/home_screen.dart';

class ProfileNameScreen extends StatefulWidget {
  ProfileNameScreen({super.key});

  @override
  State<ProfileNameScreen> createState() => _ProfileNameScreenState();
}

class _ProfileNameScreenState extends State<ProfileNameScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  void _showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(status: 'Please Wait...');
      },
    );
  }

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
                  setState(() {
                    _isLoading = true;
                  });

                  _showProgressDialog();
                  await authService.saveUserData(UserModel(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      mobileNumber: '',
                      email: _auth.currentUser!.email,
                      isLoggedin: true,
                      authProvider: "Google"));
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                  //await authService.updateLoggedInStatus(true);
                }),
          ],
        ),
      ),
    );
  }
}
