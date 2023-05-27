import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class phone_text_field extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) function;
  final Function(PhoneNumber) function2;

  const phone_text_field({
    super.key,
    required this.controller,
    required this.function,
    required this.function2,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h / 15,
      width: double.infinity,
      child: IntlPhoneField(
          controller: controller,
          keyboardType: TextInputType.number,
          onSubmitted: function,
          textInputAction: TextInputAction.go,
          disableLengthCheck: true,
          dropdownIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: 20,
          ),
          style: TextStyle(fontSize: 14),
          textAlignVertical: TextAlignVertical.center,
          showDropdownIcon: true,
          flagsButtonMargin: EdgeInsets.only(left: 10),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 1)),
            contentPadding: EdgeInsets.symmetric(vertical: h / 23),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          initialCountryCode: 'PK',
          onChanged: function2),
    );
  }
}
