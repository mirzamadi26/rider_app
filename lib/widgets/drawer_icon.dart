import 'package:flutter/material.dart';

class drawer_icon extends StatelessWidget {
  final VoidCallback function;

  drawer_icon({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
    );
  }
}
