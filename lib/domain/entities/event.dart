import 'package:confhub/domain/entities/session.dart';

class Event {
  final String title;
  final String category;
  final String date;  //  solo la fecha (YYYY-MM-DD)
  final String time;  //  solo la hora (HH:MM)
  final int attendees;
  final String description;
  final String speakerName;
  final String speakerAvatar;
  final List<Session> sessionOrder;
  final List<String> tags;

  Event({
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.attendees,
    required this.description,
    required this.speakerName,
    required this.speakerAvatar,
    required this.sessionOrder,
    required this.tags,
  });
}


