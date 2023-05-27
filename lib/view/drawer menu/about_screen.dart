import 'package:flutter/material.dart';

import '../../widgets/list_tiles.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black, size: 15),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "About",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(height: 20),
                list_tiles(
                    title: "Rate the app",
                    icon: Icon(Icons.star_border),
                    function: () {}),
                Divider(),
                list_tiles(
                    title: "Like us on Facebook",
                    icon: Icon(
                      Icons.thumb_up_alt_outlined,
                    ),
                    function: () {}),
                Divider(),
                list_tiles(
                    title: "Solutions for work trips",
                    icon: Icon(Icons.badge),
                    function: () {}),
                Divider(),
                list_tiles(
                    title: "Careers at Rider",
                    icon: Icon(Icons.favorite_outline),
                    function: () {}),
                Divider(),
                list_tiles(
                    title: "Legal",
                    icon: Icon(Icons.account_balance_rounded),
                    function: () {}),
                Divider(),
                list_tiles(
                    title: "Acknowledgements",
                    icon: Icon(Icons.insert_drive_file_outlined),
                    function: () {}),
                Divider()
              ],
            )),
          ),
        ),
      ),
    );
  }
}
