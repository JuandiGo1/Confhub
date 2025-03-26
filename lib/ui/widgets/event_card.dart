import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  
  const EventCard({super.key ,required this.eventName});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(eventName),
      ),
    );
  }
}