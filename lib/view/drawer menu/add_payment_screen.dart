import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/list_tiles.dart';
import 'add_card_screen.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
                Divider(),
                list_tiles(
                    title: "Add payment Method",
                    icon: Icon(Icons.add),
                    function: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          context: context,
                          builder: (_) {
                            return Container(
                              height: 150,
                              width: double.maxFinite,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Add payment method",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    list_tiles(
                                        title: "Add debit/credit card",
                                        icon: Icon(Icons.local_atm_sharp),
                                        function: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewCardScreen()));
                                        }),
                                    Divider(),
                                    list_tiles(
                                        title: "Add PayPal",
                                        icon: Icon(Icons.paypal),
                                        function: () {})
                                  ],
                                ),
                              ),
                            );
                          });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
