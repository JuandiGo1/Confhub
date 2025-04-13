import 'package:confhub/domain/entities/session.dart';

class Event {
  String title;
  String category;
  DateTime dateTime;
  String date; //  solo la fecha (YYYY-MM-DD)
  String time; //  solo la hora (HH:MM)
  int attendees;
  int availableSpots;
  String description;
  String location;
  int eventid;
  String speakerName;
  String speakerAvatar;
  List<Session> sessionOrder;
  List<String> tags;
  double avgScore;
  String status;
  int numberReviews;

  Event({
    required this.title,
    required this.category,
    required this.dateTime,
    required this.date,
    required this.time,
    required this.attendees,
    required this.description,
    required this.speakerName,
    required this.speakerAvatar,
    required this.sessionOrder,
    required this.tags,
    required this.location,
    required this.availableSpots,
    required this.eventid,
    required this.avgScore,
    required this.status,
    required this.numberReviews,
  });
}
