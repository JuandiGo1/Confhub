import 'package:flutter/material.dart';
import '../widgets/event_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text("Hi Coder! There are some webinars incoming"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  EventCard(
                      eventName: "React Course", eventCategorie: "Developer"),
                  EventCard(
                      eventName: "Java Course", eventCategorie: "Developer"),
                  EventCard(
                      eventName: "Css Course", eventCategorie: "Developer"),
                  EventCard(
                      eventName: "HTML Course", eventCategorie: "Developer")
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
