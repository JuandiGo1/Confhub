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
    return SizedBox(
      height: 100, // Match your card height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top line (only if not first item)
          if (!isFirst)
            Expanded(
              child: Container(
                width: 2,
                color: Colors.grey,
              ),
            ),
          
          // Always include this container to maintain alignment
          // Show circle if first item, empty space otherwise
          Container(
            width: 12,
            height: 12,
            alignment: Alignment.center,
            child: isFirst
                ? Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isToday ? Colors.blue : Colors.grey,
                      border: isToday ? null : Border.all(color: Colors.grey, width: 2),
                    ),
                  )
                : Container(
                    width: 2,
                    height: 12,
                    color: Colors.grey,
                  ),
          ),
          
          // Bottom line (only if not last item)
          if (!isLast)
            Expanded(
              child: Container(
                width: 2,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}