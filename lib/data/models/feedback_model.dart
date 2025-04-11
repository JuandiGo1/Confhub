

import 'package:confhub/core/utils/date_formatter.dart';

import 'package:confhub/domain/entities/feedback.dart';


class FeedbackModel extends Feedback {
  FeedbackModel({
    required super.title,
    required super.comment,
    required super.dateTime,
    required super.date,
    required super.time,
    required super.score,
    required super.eventid,

  });

  // Convertir JSON a EventModel
  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['dateTime']);
    return FeedbackModel(
        title: json['title'],
        comment: json['comment'],
        dateTime: dateTime,
        date: formatDate(dateTime), // Extraer solo la fecha
        time: dateTime
            .toIso8601String()
            .split('T')[1]
            .substring(0, 5), // Extraer solo la hora
        score: json['score'],
        eventid: json['eventid'],);
  }

  // Convertir Feedback a JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'comment': comment,
      'dateTime': "$date $time",
      'score': score,
      'eventid': eventid,

    };
  }
}