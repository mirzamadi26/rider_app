import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_location.dart';
import '../../widgets/textfield_widget.dart';

class WorkLocationScreen extends StatelessWidget {
  WorkLocationScreen({super.key});

  TextEditingController workLocationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Work",
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        backgroundColor: Colors.white38,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black54, size: 15),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: LocationTextFieldWidget(
                    controllerName: workLocationController,
                    klabelText: "Search Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
