import 'package:flutter/material.dart';
import 'package:riders/view/drawer%20menu/promo_code_screen.dart';

import '../../widgets/list_tiles.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promotions",
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white38,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black54, size: 15),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          children: [
            list_tiles(
                title: "Enter promo code",
                icon: Icon(Icons.discount_outlined),
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PromoCodeScreen()));
                }),
            Divider(
              thickness: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Icon(Icons.discount_outlined),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text("Your promotions will appear here"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
