import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/database_service.dart';
import '../../widgets/myTrips_tile.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  List<Map<String, dynamic>> completedRides = [];
  Future<void> fetchCompletedRides() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid; // Replace with the actual user ID

    List<Map<String, dynamic>> rides =
        await DatabaseService().getCompletedRides(userId);

    setState(() {
      completedRides = rides;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCompletedRides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Trips",
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white38,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black54, size: 15),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: completedRides.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> rideData = completedRides[index];
          String destinationAddress = rideData['destination_address'];
          String createdAt = rideData['created_at'];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      myTrips_tile(
                        text: destinationAddress,
                        date: createdAt,
                        price: "12.00£",
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
