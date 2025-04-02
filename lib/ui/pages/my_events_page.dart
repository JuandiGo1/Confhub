// presentation/pages/my_events_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:confhub/ui/widgets/timeline/event_timeline_widget.dart';
import 'package:confhub/ui/widgets/timeline/day_header.dart';
import 'package:confhub/ui/widgets/timeline/event_card.dart';
import 'package:confhub/domain/entities/event.dart';


class MyEventsPage extends StatelessWidget {
  final List<Event> events;

  const MyEventsPage({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final currentMonthYear = DateFormat('MMMM yyyy').format(today);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentMonthYear,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            final eventDate = event.dateTime;
            final isToday = DateUtils.isSameDay(today, eventDate);
            final isFirstOfDay = index == 0 ||
                !DateUtils.isSameDay(eventDate, events[index - 1].dateTime);
            final isLastOfDay = index == events.length - 1 ||
                !DateUtils.isSameDay(eventDate, events[index + 1].dateTime);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isFirstOfDay)
                  DayHeader(eventDate: eventDate, isToday: isToday),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventTimelineWidget(
                      isFirst: isFirstOfDay,
                      isLast: isLastOfDay,
                      isToday: isToday,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: EventCard(event: event, isToday: isToday),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

 /// A simple mock of events with different dates.
  List<Map<String, dynamic>> _mockEvents() {
    return [
      {
        "title": "Introducción a Flutter",
        "category": "Frontend",
        "location": "Bogotá, Colombia",
        "dateTime": "${DateTime.now().subtract(const Duration(days: 1)).toIso8601String()}",
        "time": "10:00",
        "speakerAvatar": "https://avatar.iran.liara.run/username?username=Juan+Perez",
      },
      {
        "title": "Node.js y Express",
        "category": "Backend",
        "location": "Barranquilla, Colombia",
        "dateTime": "${DateTime.now().toIso8601String()}",
        "time": "14:00",
        "speakerAvatar": "https://avatar.iran.liara.run/username?username=Carlos+Rios",
      },
      {
        "title": "Arquitectura de Microservicios",
        "category": "Cloud",
        "location": "Medellín, Colombia",
        "dateTime": "${DateTime.now().add(const Duration(days: 2)).toIso8601String()}",
        "time": "09:30",
        "speakerAvatar": "https://avatar.iran.liara.run/username?username=Ana+Gomez",
      },
      {
        "title": "Deep Dive into Cloud",
        "category": "Cloud",
        "location": "Medellín, Colombia",
        "dateTime": "${DateTime.now().add(const Duration(days: 2)).toIso8601String()}",
        "time": "11:00",
        "speakerAvatar": "https://avatar.iran.liara.run/username?username=Ana+Gomez",
      },
      {
        "title": "Microservices Best Practices",
        "category": "Cloud",
        "location": "Medellín, Colombia",
        "dateTime": "${DateTime.now().add(const Duration(days: 3)).toIso8601String()}",
        "time": "13:30",
        "speakerAvatar": "https://avatar.iran.liara.run/username?username=Ana+Gomez",
      },
    ];
  }