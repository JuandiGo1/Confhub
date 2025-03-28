import 'package:flutter/material.dart';

class Webinarcard extends StatelessWidget {
  final String title;
  final String date;
  final String category;
  final Color color;

  const Webinarcard(
      {super.key,
      required this.title,
      required this.date,
      required this.category,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Spacer(),
          Text(" $date", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
