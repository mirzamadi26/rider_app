import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';

class PromoCodeScreen extends StatelessWidget {
  PromoCodeScreen({super.key});
  TextEditingController _promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter promo code",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
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
                controllerName: _promoCodeController,
                klabelText: "Promo Code",
              ),
              SizedBox(
                height: 20,
              ),
              textWidget(
                  text: "The promo will be applied to your next trip",
                  color: Colors.black54),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.7,
              ),
              ButtonWidget(
                  backgroundColor: AppColors.mainColor,
                  text: "Apply",
                  textColor: Colors.white,
                  function: () {})
            ],
          ),
        ),
      ),
    );
  }
}
