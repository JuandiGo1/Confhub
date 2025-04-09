import 'package:confhub/core/colors.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';
import 'package:confhub/ui/pages/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:get/get.dart';

class CardEvent extends StatelessWidget {
  final Event event;
  final int color;

  const CardEvent({super.key, required this.color, required this.event});

  Color _getColorFromCode(int code) {
    switch (code) {
      case 0:
        return const Color.fromRGBO(53, 144, 243, 1);
      case 1:
        return const Color.fromRGBO(81, 123, 97, 1);
      case 2:
        return AppColors.cardThird;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color mColor = _getColorFromCode(color);

    return GestureDetector(
      onTap: () {
        Get.to(
          () => EventDetailPage(
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
            colorName: mColor,
          ),
          transition: Transition.cupertino,
        );
        
        Get.put<EventPageController>(EventPageController(
            initialAttendees: event.attendees, initialSpots: event.availableSpots));
      },
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: mColor,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(event.title,
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)))),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.background, // Color del borde
                    width: 1.0, // Grosor del borde
                  ),
                ),
              ),
              child: Text(
                event.date,
                style: TextStyle(
                  color: AppColors.background,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  '${event.attendees} en vivo',
                  style: TextStyle(color: AppColors.textPrimary),
                ))
          ],
        ),
      ),
    );
  }
}
