// presentation/widgets/event_card.dart
import 'package:flutter/material.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/core/colors.dart';

// presentation/widgets/event_card.dart
class EventCard extends StatelessWidget {
  final Event event;
  final bool isToday;
  final Color? cardColor; // Optional parameter for custom colors

  const EventCard({
    super.key,
    required this.event,
    required this.isToday,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = isToday ? AppColors.background : Colors.white;
    
    return Card(
      elevation: 2,
      color: cardColor ?? defaultColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.background,
          backgroundImage: NetworkImage(event.speakerAvatar),
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
    );
  }
}