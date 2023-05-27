import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riders/view/drawer%20menu/work_location.dart';

import '../../model/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../services/image_service.dart';
import '../../widgets/list_tiles.dart';
import '../../widgets/profile_widget.dart';
import '../authentication/welcome_screen.dart';
import 'edit_profile_screen.dart';
import 'home_location_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _profileImageUrl = '';
  final User? user = FirebaseAuth.instance.currentUser;
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
    if (user != null) {
      _fetchProfileImage(user!.uid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
                },
                icon: Icon(Icons.edit))
          ],
          backgroundColor: Colors.white38,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.black54, size: 20),
          elevation: 0,
        ),
        body: ListView(children: [
          Container(
            width: double.maxFinite,
            height: h / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                FutureBuilder(
                  future: DatabaseService.fetchUserName(),
                  builder: ((context, AsyncSnapshot<UserModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    thickness: 5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorite Location",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                list_tiles(
                    title: "Enter home location",
                    icon: Icon(Icons.home_filled),
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeLocationScreen()));
                    }),
                Divider(),
                list_tiles(
                    title: "Enter work location",
                    icon: Icon(Icons.work_outline_rounded),
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkLocationScreen()));
                    }),
                Divider(
                  thickness: 5,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                list_tiles(
                  title: "Language",
                  function: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Divider(thickness: 5),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
            ),
            child: Column(children: [
              list_tiles(
                  title: "Log out",
                  icon: Icon(Icons.login),
                  function: () async {
                    await authService.logOut().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen())));
                    await authService.updateLoggedInStatus(false);
                  }),
              Divider(),
              list_tiles(
                  title: "Delete Account",
                  icon: Icon(Icons.delete),
                  function: () async {
                    DatabaseService().deleteUserAccount();
                    DatabaseService().deleteUserDataFromFirestore(user!.uid);
                    await authService.logOut();

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                        (route) => false);
                  }),
            ]),
          )
        ]));
  }
}
