import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:riders/view/authentication/profile_number_screen.dart';
import 'package:riders/view/authentication/welcome_screen.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/opt_button.dart';
import '../home/home_screen.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({
    super.key,
  });

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var code;
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter Code",
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        backgroundColor: Colors.white38,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black54, size: 15),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("A code was sent to"),
                Text("+12124551"),
                TextButton(
                    style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero),
                    onPressed: () {},
                    child: Text(
                      "Edit phone number",
                      style: TextStyle(color: AppColors.mainColor),
                    )),
                SizedBox(
                  height: 20,
                ),
                OTPTextField(
                  length: 6,
                  width: double.maxFinite,
                  fieldWidth: 40,
                  onChanged: (value) {
                    code = value;
                  },
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero),
                    onPressed: () {},
                    child: Text(
                      "Resend Code",
                      style: TextStyle(color: AppColors.mainColor),
                    )),
                OtpButton(
                    kwidth: 100,
                    backgroundColor: AppColors.mainColor,
                    text: "Continue",
                    textColor: Colors.white,
                    function: () async {
                      try {
                        // Create a PhoneAuthCredential with the code

                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: WelcomeScreen.verify,
                                smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        final userExists = await authService.checkUserExists();
                        if (userExists) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileNumberScreen()));
                        }
                      } catch (e) {
                        Utils.snackBar("Please Enter Correct OTP", context);
                      }

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginScreen()));
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
