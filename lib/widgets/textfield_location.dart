import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class LocationTextFieldWidget extends StatelessWidget {
  const LocationTextFieldWidget({
    super.key,
    required this.controllerName,
    this.borderRadius = 5,
    required this.klabelText,
  });
  final TextEditingController controllerName;
  final String klabelText;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerName,
      decoration: InputDecoration(
          prefixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              )),
          filled: true,
          fillColor: Colors.white38,
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.map_outlined,
                color: AppColors.mainColor,
              )),
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
