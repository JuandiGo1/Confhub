import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final String eventId;
  
  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles del Evento")),
      body: Center(child: Text("Detalles del evento con ID: $eventId")),
    );
  }
}