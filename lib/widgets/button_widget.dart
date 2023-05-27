import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final VoidCallback function;
  const ButtonWidget(
      {super.key,
      required this.backgroundColor,
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
            color: backgroundColor, borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 15, color: textColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
