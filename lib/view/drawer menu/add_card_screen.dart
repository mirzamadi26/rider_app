import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/textfield_widget.dart';

class NewCardScreen extends StatelessWidget {
  NewCardScreen({super.key});

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController secureCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "New Card",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16),
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
                TextFieldWidget(
                  controllerName: cardNumberController,
                  klabelText: "Email",
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        // optional flex property if flex is 1 because the default flex is 1
                        flex: 1,
                        child: TextFieldWidget(
                            controllerName: expiryDateController,
                            klabelText: "MM / YY")),
                    SizedBox(width: 10.0),
                    Expanded(
                        // optional flex property if flex is 1 because the default flex is 1
                        flex: 1,
                        child: TextFieldWidget(
                            controllerName: secureCodeController,
                            klabelText: "SecureCode")),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.9,
                ),
                ButtonWidget(
                    backgroundColor: AppColors.mainColor,
                    text: "Add card",
                    textColor: Colors.white,
                    function: () {})
              ],
            ),
          ),
        ));
  }
}
