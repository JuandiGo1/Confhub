import 'package:confhub/core/utils/date_formatter.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/data/models/session_model.dart';

class EventModel extends Event {
  EventModel({
    required super.title,
    required super.category,
    required super.date,
    required super.time,
    required super.attendees,
    required super.description,
    required super.speakerName,
    required super.speakerAvatar,
    required List<SessionModel> super.sessionOrder,
    required super.tags,
  });

  // Convertir JSON a EventModel
  factory EventModel.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['dateTime']);
    return EventModel(
      title: json['title'],
      category: json['category'],
      date: formatDate(dateTime),  // Extraer solo la fecha
      time: dateTime.toIso8601String().split('T')[1].substring(0, 5), // Extraer solo la hora
      attendees: json['attendees'],
      description: json['description'],
      speakerName: json['speakerName'],
      speakerAvatar: json['speakerAvatar'],
      sessionOrder: (json['sessionOrder'] as List)
          .map((session) => SessionModel.fromJson(session))
          .toList(),
      tags: List<String>.from(json['tags']),
    );
  }

  // Convertir EventModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'dateTime': "$date $time",
      'attendees': attendees,
      'description': description,
      'speakerName': speakerName,
      'speakerAvatar': speakerAvatar,
      'sessionOrder': sessionOrder
          .map((session) => (session as SessionModel).toJson())
          .toList(),
      'tags': tags,
    };
  }



}
