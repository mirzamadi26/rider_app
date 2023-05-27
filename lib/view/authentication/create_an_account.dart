import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/button_with_icon_widget.dart';
import '../../widgets/text_widget.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                    text: "Create an account",
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: [
                      TextSpan(
                          text:
                              'Save time by linking your social account. We will \n',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12)),
                      TextSpan(
                          text: 'never share any personal data',
                          style: TextStyle(color: Colors.black54, fontSize: 12))
                    ])),
                const SizedBox(
                  height: 20,
                ),
                ButtonwithIconWidget(
                    backgroundColor: Colors.white,
                    text: "Sign in with Google",
                    textColor: Colors.black87,
                    function: () {}),
                SizedBox(
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
                ButtonWidget(
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    text: "Continue with email",
                    textColor: Colors.black,
                    function: () {}),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
          ]),
    )));
  }
}
