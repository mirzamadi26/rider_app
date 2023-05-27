import 'package:flutter/material.dart';

class OtpButton extends StatefulWidget {
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final double kwidth;
  final VoidCallback function;
  const OtpButton(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.kwidth,
      required this.textColor,
      required this.function});

  @override
  State<OtpButton> createState() => _OtpButtonState();
}

class _OtpButtonState extends State<OtpButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.function,
      child: Container(
        width: widget.kwidth,
        height: MediaQuery.of(context).size.height / 20,
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 16,
                color: widget.textColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
