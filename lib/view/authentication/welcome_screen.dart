import 'package:flutter/material.dart';
import 'package:riders/view/authentication/profile_name_screen.dart';
import '../../services/auth_service.dart';
import '../../widgets/button_with_icon_widget.dart';
import '../../widgets/phone_field_widget.dart';
import '../../widgets/progress_dialog.dart';
import '../../widgets/terms_and_conditions.dart';
import '../../widgets/text_widget.dart';
import '../home/home_screen.dart';
import 'otp_verification.dart';

class WelcomeScreen extends StatefulWidget {
  static String verify = '';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = false;
  bool isPhoneLoading = false;
  String fullPhone = '';
  TextEditingController numberController = TextEditingController();
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
        body: Center(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textWidget(
                      text: "Enter your Number",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  const SizedBox(
                    height: 20,
                  ),
                  phone_text_field(
                    function2: (phone) {
                      print(phone.completeNumber);
                      setState(() {
                        fullPhone = phone.completeNumber;
                      });
                    },
                    function: (value) {
                      setState(() {
                        isPhoneLoading = true;
                      });

                      _showProgressDialog();
                      AuthService().otpVerificaion(fullPhone, context);
                      Navigator.pop(context);
                      setState(() {
                        isPhoneLoading = false;
                      });

                      print(fullPhone);
                    },
                    controller: numberController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonwithIconWidget(
                      backgroundColor: Colors.white,
                      text: "Sign in with Google",
                      textColor: Colors.black87,
                      function: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await authService.signInWithGoogle(context);
                        final userExists = await authService.checkUserExists();
                        setState(() {
                          _isLoading = false;
                        });
                        if (userExists) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileNameScreen()));
                        }
                      }),
                  if (_isLoading)
                    Center(child: ProgressDialog(status: 'Signing in...')),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              terms_and_conditions(),
            ]),
      )),
    ));
  }
}
