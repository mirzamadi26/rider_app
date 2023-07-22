import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ProgressDialog extends StatelessWidget {
  final String status;
  const ProgressDialog({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(width: 5),
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.mainColor),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    status,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
