import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/use_cases/get_events_category.dart';
import 'package:confhub/ui/widgets/enventLines/card_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventCategory extends StatelessWidget {
  final String category;
  EventCategory({super.key, required this.category});

  final getEventsByCategory = Get.find<GetEventsByCategory>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              category,
              style: TextStyle(fontSize: 18),
            )),
        FutureBuilder(
            future: getEventsByCategory.call(category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              } else if (snapshot.hasError) {
                return Text('Error.');
              }

              List<Event> categories = snapshot.data ?? [];
              return Row(
                spacing: 10,
                  children: categories.map((e) {
                return CardEvent(eventAmount: e.attendees, title: e.title);
              }).toList());
            })
      ],
    );
  }
}
