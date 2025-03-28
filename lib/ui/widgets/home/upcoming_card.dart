import 'package:flutter/material.dart';

class UpcomingCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String category;

  const UpcomingCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Row(
            children: [
              Chip(label: Text(category)),
              Spacer(),
              Text(time),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("📅 $date"),
              ElevatedButton(
                onPressed: () {},
                child: Text("Join Now"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
