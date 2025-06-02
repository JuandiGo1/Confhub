import 'dart:developer';

import 'package:confhub/core/utils/date_formatter.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/data/models/session_model.dart';
import 'dart:io';

class EventModel extends Event {
  EventModel(
      {required super.title,
      required super.category,
      required super.dateTime,
      required super.date,
      required super.time,
      required super.attendees,
      required super.description,
      required super.speakerName,
      required super.speakerAvatar,
      required super.location,
      required super.availableSpots,
      required List<SessionModel> super.sessionOrder,
      required super.tags,
      required super.eventid,
      required super.avgScore,
      required super.status,
      required super.numberReviews,
      required super.track,
      required super.userInfo});

  // Convertir JSON a EventModel
  factory EventModel.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['datetime']);
    return EventModel(
        title: json['title'],
        category: json['category'],
        dateTime: dateTime,
        date: formatDate(dateTime), // Extraer solo la fecha
        time: dateTime
            .toIso8601String()
            .split('T')[1]
            .substring(0, 5), // Extraer solo la hora
        attendees: json['attendees'],
        availableSpots: json['availablespots'],
        description: json['description'],
        speakerName: json['speakername'],
        speakerAvatar: json['speakeravatar'],
        location: json['location_'],
        sessionOrder: (json['sessionorder'] as List)
            .map((session) => SessionModel.fromJson(session))
            .toList(),
        tags: List<String>.from(json['tags']),
        eventid: json['eventid'],
        avgScore: json['avgscore'],
        status: json['status'],
        numberReviews: json['numberreviews'],
        track: json['track'],
        userInfo: json['user_info']);
  }

  // Convertir EventModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'dateTime': "$date $time",
      'attendees': attendees,
      'availableSpots': availableSpots,
      'description': description,
      'speakerName': speakerName,
      'speakerAvatar': speakerAvatar,
      'sessionOrder': sessionOrder
          .map((session) => (session as SessionModel).toJson())
          .toList(),
      'tags': tags,
      'location': location,
      'eventid': eventid,
      'avgScore': avgScore,
      'status': status,
      'numberReviews': numberReviews,
      'track': track,
      'userInfo': userInfo,
    };
  }
}
