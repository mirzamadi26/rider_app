import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/list_tiles.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
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
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rider Balance"),
                    Text(
                      '0£',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Rider Balance is not availabe with this rider balance",
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            list_tiles(
                title: "What is Rider Balance",
                icon: Icon(Icons.contact_support_outlined),
                function: () {}),
            Divider(),
            list_tiles(
                title: "See transactions",
                icon: Icon(Icons.timelapse_outlined),
                function: () {}),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  "Payment Methods",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: AppColors.mainColor,
                          size: 20,
                        ),
                        Text("Cash"),
                      ],
                    ),
                    Radio(value: 1, groupValue: 1, onChanged: (val) {})
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
