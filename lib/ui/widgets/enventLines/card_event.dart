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
        return AppColors.primary;
      case 1:
        return AppColors.cardSecond;
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
            eventavgScore: event.avgScore,
            eventstatus: event.status,
            eventSessionOrder: event.sessionOrder,
            numberReviews: event.numberReviews,
          ),
          transition: Transition.cupertino,
        );

        Get.put<EventPageController>(EventPageController(
            initialAttendees: event.attendees,
            initialSpots: event.availableSpots));
      },
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          color: mColor,
          border: Border.all(
            color: Colors.white, // Color del borde
            width: 5.0,
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
                            color: mColor == AppColors.primary
                                ? Colors.white
                                : AppColors.title,
                            fontSize: 19,
                            fontWeight: FontWeight.w600)))),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: mColor == AppColors.primary
                        ? Colors.white
                        : AppColors.title, // Color del borde
                    width: 2.0, // Grosor del borde
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  event.date,
                  style: TextStyle(
                      color: mColor == AppColors.primary
                          ? Colors.white
                          : AppColors.title,
                      backgroundColor: Colors.transparent,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
