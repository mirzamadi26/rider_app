import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.controllerName,
    this.borderRadius = 5,
    this.onChanged,
    this.focus,
    required this.klabelText,
  });
  final TextEditingController controllerName;
  final String klabelText;
  var focus;
  final double? borderRadius;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerName,
      focusNode: focus,
      onChanged: onChanged,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white38,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          labelText: klabelText,
          labelStyle: TextStyle(color: Colors.black54),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide:
                  const BorderSide(color: AppColors.mainColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide:
                  const BorderSide(color: AppColors.mainColor, width: 1))),
    );
  }
}

class TextFieldIcons extends StatelessWidget {
  TextFieldIcons(
      {super.key,
      required this.controllerName,
      this.borderRadius = 5,
      required this.klabelText,
      this.pIcon,
      this.function});
  final TextEditingController controllerName;
  final String klabelText;
  final double? borderRadius;
  final Icon? pIcon;

  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controllerName,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white38,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            labelText: klabelText,
            prefixIcon: pIcon,
            labelStyle: TextStyle(color: Colors.black54),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide:
                    const BorderSide(color: AppColors.mainColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide:
                    const BorderSide(color: AppColors.mainColor, width: 1))),
      ),
    );
  }
}
