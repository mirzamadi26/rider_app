import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../services/database_service.dart';
import '../services/image_service.dart';
import '../view/drawer menu/about_screen.dart';
import '../view/drawer menu/mytrips_screen.dart';
import '../view/drawer menu/payment_screen.dart';
import '../view/drawer menu/profile_screen.dart';
import '../view/drawer menu/promotion_screen.dart';

import 'list_tiles.dart';

class MyDrawerHeader extends StatefulWidget {
  const MyDrawerHeader({super.key});

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  String _profileImageUrl = '';
  void _fetchProfileImage(String userId) async {
    final imageUrl = await ImageService.fetchProfileImageUrl(userId);
    if (imageUrl != null) {
      setState(() {
        _profileImageUrl = imageUrl;
      });
    }
  }

  @override
  void initState() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _fetchProfileImage(user.uid);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
      height: h / 1.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: Row(
              children: [
                Container(
                  width: w / 3,
                  height: h / 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _profileImageUrl != null
                              ? NetworkImage(_profileImageUrl)
                              : AssetImage('assets/placeholder.png')
                                  as ImageProvider,
                          fit: BoxFit.cover)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: DatabaseService.fetchUserName(),
                      builder: ((context, AsyncSnapshot<UserModel> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          final user = snapshot.data;
                          return Text('${user!.firstName}',
                              style: TextStyle(fontWeight: FontWeight.bold));
                        }
                      }),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero),
                        onPressed: () {},
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 11),
                        ))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                list_tiles(
                  title: "Payment",
                  icon: Icon(Icons.payment),
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen()));
                  },
                ),
                list_tiles(
                  title: "Support",
                  icon: Icon(Icons.contact_support_outlined),
                  function: () {},
                ),
                list_tiles(
                  title: "My Trips",
                  icon: Icon(Icons.timelapse_rounded),
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyTripsScreen()));
                  },
                ),
                list_tiles(
                  title: "About",
                  icon: Icon(Icons.info_rounded),
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutScreen()));
                  },
                ),
              ],
            ),
          ),
          Divider(
            thickness: 5,
          )
        ],
      ),
    );
  }
}
