import 'package:flutter/material.dart';

class CardEvent extends StatelessWidget {
  final int eventAmount;
  final String title;

  const CardEvent({super.key, required this.eventAmount, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 120,
      height: 120,
      color: Colors.blue,
      child: Column(
        children: [
          Expanded(child: Text(title, style: TextStyle(fontSize: 12))),
          Text('$eventAmount en vivo')
        ],
      ),
    );
  }
}
