import 'dart:math';

import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';
import 'package:confhub/ui/pages/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Webinarcard extends StatelessWidget {
  final String title;
  final String date;
  final String category;
  final Color color;
  final int attendees; // Número de asistentes
  final String speakerAvatar; // URL o ruta del avatar del speaker
  final Event event;
  const Webinarcard(
      {super.key,
      required this.title,
      required this.date,
      required this.category,
      required this.color,
      required this.attendees,
      required this.speakerAvatar,
      required this.event});

  @override
  Widget build(BuildContext context) {
    final colorText =
        color == AppColors.primary ? Colors.white : AppColors.secondary;

    return GestureDetector(
      onTap: () {
        Get.to(() => EventDetailPage(
              eventTitle: event.title,
              eventId: event.eventid,
              eventDate: event.date,
              eventAttendees: event.attendees,
              eventCategory: event.category,
              eventDescription: event.description,
              eventSpeakerAvatar: event.speakerAvatar,
              eventTime: event.time,
              eventSpeakerName: event.speakerName,
              eventLocation: event.location,
              eventSpots: event.availableSpots,
            ));

        Get.put<EventPageController>(EventPageController(
            initialAttendees: event.attendees, initialSpots: event.availableSpots));
      },
      child: Container(
        width: 180,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category,
                style:
                    TextStyle(color: colorText, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorText)),
            Spacer(),
            Text(" $date", style: TextStyle(color: colorText)),
            SizedBox(height: 8),
            SizedBox(height: 8), // Espaciado entre la fecha y la nueva fila
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.campaign, color: colorText, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "Orador",
                      style: TextStyle(color: colorText, fontSize: 14),
                    ),
                    SizedBox(width: 5),
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(speakerAvatar),
                      backgroundColor: Colors.grey[200],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
