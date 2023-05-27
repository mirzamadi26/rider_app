import 'package:flutter/material.dart';

class terms_and_conditions extends StatelessWidget {
  const terms_and_conditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: '',
              children: <TextSpan>[
                TextSpan(
                  text: 'If you are creating a new account,',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                TextSpan(
                    text: ' Terms & Conditions',
                    style: TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.underline,
                        fontSize: 12)),
                TextSpan(
                    text: ' and ',
                    style: TextStyle(color: Colors.black54, fontSize: 12)),
                TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.underline,
                        fontSize: 12)),
                TextSpan(
                    text: ' will apply',
                    style: TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
