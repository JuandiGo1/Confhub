import 'package:flutter/material.dart';

class EventTimelineWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isToday;
  final bool isSolo; // <- New flag for single event in the day

  const EventTimelineWidget({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isToday,
    this.isSolo = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isSolo) {
      return Column(
        children: [
          Expanded(child: SizedBox()), // spacer
          Center(
            child: Dot(isToday: isToday), // always show the dot in center
          ),
          Expanded(child: SizedBox()), // spacer
        ],
      );
    }

    return Column(
      children: [
        // Top line (slightly extended downward)
        Expanded(
          flex: isFirst ? 0 : 1,
          child: isFirst
              ? const SizedBox()
                : Transform.translate(
                  offset: Offset(0, -MediaQuery.of(context).size.height * 0.03),
                  child: Container(width: 2, color: Colors.grey),
                ),
        ),

        // The dot
        Container(
          width: 12,
          height: 12,
          child: Opacity(
            opacity: isFirst ? 1.0 : 0.0,
            child: Dot(isToday: isToday),
          ),
        ),

        // Bottom line (slightly extended upward)
        Expanded(
          flex: isLast ? 0 : 1,
          child: isLast
              ? const SizedBox()
              : Transform.translate(
                  offset: const Offset(0, -4),
                  child: Container(width: 2, color: Colors.grey),
                ),
        ),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  final bool isToday;

  const Dot({super.key, required this.isToday});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isToday ? Colors.blue  : Colors.grey,
        shape: BoxShape.circle,
        border: isToday ? null : Border.all(color: Colors.grey, width: 2),
      ),
    );
  }
}
