// presentation/widgets/event_card.dart
import 'package:flutter/material.dart';
import 'package:confhub/domain/entities/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final bool isToday;

  const EventCard({
    super.key,
    required this.event,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isToday ? Colors.blue.shade50 : Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(event.speakerAvatar),
        ),
        title: Text(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${event.time} - ${event.location}'),
            if (event.speakerName.isNotEmpty)
              Text(
                'Speaker: ${event.speakerName}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        trailing: event.availableSpots > 0
            ? Chip(
                label: Text('${event.availableSpots} spots'),
                backgroundColor: isToday ? Colors.blue[100] : Colors.grey[200],
              )
            : const Chip(
                label: Text('Full'),
                backgroundColor: Colors.red,
              ),
      ),
    );
  }
}