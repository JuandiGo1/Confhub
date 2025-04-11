import 'dart:convert';
import 'package:confhub/data/models/feedback_model.dart';
import 'package:flutter/services.dart';


class FeedbackLocalDataSource {
  Future<List<FeedbackModel>> getAllFeedbacks() async {
    final String response =
        await rootBundle.loadString('assets/data/feedback.json');

    final List<dynamic> data = json.decode(response);

    return data.map((json) => FeedbackModel.fromJson(json)).toList();
  }

  Future<List<FeedbackModel>> getAllFeedbacksFromAnEvent(
      int eventid, String filtro) async {
    final allFeedbacksForAnEvent = await getAllFeedbacks();

    final List<FeedbackModel> feedbacks = allFeedbacksForAnEvent
        .where((feedback) => feedback.eventid == eventid)
        .toList();

    feedbacks.sort((f1, f2) {
      if (filtro == "Asc") {
        return f1.dateTime.compareTo(f2.dateTime);
      } else if (filtro == "Desc") {
        return f2.dateTime.compareTo(f1.dateTime);
      } else if (filtro == "BScore") {
        return f1.score.compareTo(f2.score);
      } else if (filtro == "WScore") {
        return f2.score.compareTo(f1.score);
      }

      return f1.dateTime.compareTo(f2.dateTime);
    });

    return feedbacks;
  }
}
