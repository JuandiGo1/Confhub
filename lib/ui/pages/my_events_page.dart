import 'package:flutter/material.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mis Eventos")),
      body: Center(child: Text("Eventos en los que te has inscrito")),
    );
  }
}
