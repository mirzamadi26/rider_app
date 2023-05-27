import 'package:flutter/material.dart';

class list_tiles extends StatelessWidget {
  String title;
  Icon? icon;
  VoidCallback function;

  list_tiles({
    required this.title,
    this.icon,
    required this.function,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: function,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            leading: icon,
            iconColor: Colors.black54,
            title: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ));
  }
}

class payment_tiles extends StatelessWidget {
  String title;

  String imgPath;
  VoidCallback function;
  payment_tiles({
    required this.title,
    required this.imgPath,
    required this.function,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        leading: SizedBox(
          height: 20,
          width: 20,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(imgPath),
          ),
        ),
        iconColor: Colors.black54,
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }
}
