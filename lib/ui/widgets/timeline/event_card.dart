import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/core/colors.dart';
import 'package:confhub/ui/pages/event_detail_page.dart';
import 'package:get/get.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final bool isToday;
  final Color? cardColor;

  const EventCard({
    super.key,
    required this.event,
    required this.isToday,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = isToday ? AppColors.background : Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          HapticFeedback.lightImpact();
          _navigateToEventDetails();
        },
        child: Hero(
          tag: 'event-${event.eventid}',
          child: Card(
            elevation: 2,
            color: cardColor ?? defaultColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.background,
                    backgroundImage: NetworkImage(event.speakerAvatar),
                    onBackgroundImageError: (_, __) => const Icon(Icons.person),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${event.time} - ${event.location}',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        if (event.speakerName.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              'Orador: ${event.speakerName}',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: event.availableSpots - 1 > 0
                          ? AppColors.secondary
                          : AppColors.error,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          event.availableSpots - 1 > 0
                              ? Icons.event_available
                              : Icons.event_busy,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          event.availableSpots - 1 > 0
                              ? '${event.availableSpots - 1} libres'
                              : 'Lleno',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToEventDetails() {
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
        eventavgScore: event.avgScore,
        eventstatus: event.status,
        eventSessionOrder: event.sessionOrder,
        numberReviews: event.numberReviews,
      ),
      transition: Transition.cupertino,
    );

    if (!Get.isRegistered<EventPageController>()) {
      Get.put(EventPageController(
        initialAttendees: event.attendees,
        initialSpots: event.availableSpots,
      ));
    }
  }
}