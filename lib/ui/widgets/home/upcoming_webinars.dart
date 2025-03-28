import 'package:confhub/ui/widgets/home/upcoming_card.dart';
import 'package:flutter/material.dart';

class UpcomingWebinars extends StatelessWidget {
  const UpcomingWebinars({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          UpcomingCard(
              title: "UX Research Method - Surja",
              date: "Today",
              time: "12:10 PM - 2:00 PM",
              category: "Design"),
        ],
      ),
    );
  }
}