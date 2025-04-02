// presentation/widgets/day_header.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class DayHeader extends StatelessWidget {
  final DateTime eventDate;
  final bool isToday;

  const DayHeader({
    super.key,
    required this.eventDate,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('EEEE', 'es_ES').format(eventDate).capitalize();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "${DateFormat('dd').format(eventDate)} $dayName",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isToday ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}