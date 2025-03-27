import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  final String eventCategorie;
  
  const EventCard({super.key ,required this.eventName, required this.eventCategorie});
  
  @override
  Widget build(BuildContext context) {
    return Card(
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(eventCategorie, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Text(eventName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text("Fecha: 12 de abril - 3:00 PM"),
      ],
    ),
  ),
);
  }
}