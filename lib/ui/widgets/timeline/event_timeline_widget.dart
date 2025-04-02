// presentation/widgets/event_timeline_widget.dart
import 'package:flutter/material.dart';

class EventTimelineWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isToday;

  const EventTimelineWidget({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirst)
          Container(
            height: 60,
            width: 2,
            color: Colors.grey,
          ),
        isFirst
            ? Icon(
                Icons.circle,
                size: 12,
                color: isToday ? Colors.blue : Colors.grey,
              )
            : Container(
                height: 12,
                width: 12,
              ),
        if (!isLast)
          Container(
            height: 60,
            width: 2,
            color: Colors.grey,
          ),
      ],
    );
  }
}