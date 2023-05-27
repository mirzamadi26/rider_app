import 'package:flutter/material.dart';

class ButtonwithIconWidget extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final VoidCallback function;
  const ButtonwithIconWidget(
      {required this.backgroundColor,
      required this.text,
      required this.textColor,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                  child: Image.asset(
                'assets/google.png',
                height: 18,
              )),
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 14, color: textColor),
            )
          ],
        ),
      ),
    );
  }
}
