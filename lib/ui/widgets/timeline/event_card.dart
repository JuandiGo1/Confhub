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
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.background,
                backgroundImage: NetworkImage(event.speakerAvatar),
                onBackgroundImageError: (_, __) => const Icon(Icons.person),
              ),
              title: Text(
                event.title,
                style: TextStyle(color: AppColors.textPrimary),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${event.time} - ${event.location}',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  if (event.speakerName.isNotEmpty)
                    Text(
                      'Orador: ${event.speakerName}',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              trailing: event.availableSpots > 0
                  ? Chip(
                      label: Text(
                        '${event.availableSpots} Disponibles',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: AppColors.secondary,
                    )
                  : Chip(
                      label: const Text(
                        'Full',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: AppColors.error,
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
      ),
      transition: Transition.cupertino,
    );

    if (!Get.isRegistered<EventPageController>()) {
      Get.put(EventPageController(
        attendees: event.attendees,
        spots: event.availableSpots,
      ));
    }
  }
}