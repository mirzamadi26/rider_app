import 'package:flutter/material.dart';

class myTrips_tile extends StatelessWidget {
  final String text;
  final String date;
  final String price;

  const myTrips_tile({
    super.key,
    required this.text,
    required this.date,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
        leading: CircleAvatar(
          radius: 15,
          child: Icon(Icons.car_repair),
        ),
        title: Text(
          text,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          date,
          style: TextStyle(fontSize: 10),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
