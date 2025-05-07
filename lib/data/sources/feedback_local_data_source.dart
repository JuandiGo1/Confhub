import 'dart:convert';
import 'package:confhub/data/models/feedback_model.dart';
import 'package:confhub/domain/entities/feedback.dart';
import 'package:flutter/services.dart';

class FeedbackLocalDataSource {
  Future<List<FeedbackModel>> getAllFeedbacks() async {
    final String response = await rootBundle.loadString('data/feedback.json');

    final List<dynamic> data = json.decode(response);

    return data.map((json) => FeedbackModel.fromJson(json)).toList();
  }

  Future<List<FeedbackModel>> getAllFeedbacksFromAnEvent(
      int eventid, String filtro) async {
    final allFeedbacksForAnEvent = await getAllFeedbacks();

    final List<FeedbackModel> feedbacks = allFeedbacksForAnEvent
        .where((feedback) => feedback.eventid == eventid)
        .toList();

    if (filtro == "Recientes") {
      feedbacks.sort((f1, f2) {
        return f1.dateTime.compareTo(f2.dateTime);
      });
    } else if (filtro == "Antiguos") {
      feedbacks.sort((f1, f2) {
        return f2.dateTime.compareTo(f1.dateTime);
      });
    } else if (filtro == "MejorVal") {
      feedbacks.sort((f1, f2) {
        return (f2.likes - f2.dislikes).compareTo(f1.likes - f1.dislikes);
      });
    } else if (filtro == "PeorVal") {
      feedbacks.sort((f1, f2) {
        return (f1.likes - f1.dislikes).compareTo(f2.likes - f2.dislikes);
      });
    }

    return feedbacks;
  }

  Future<bool> likeAFeedback(int eventid) async {
    // placeholder
    final allFeedbacksForAnEvent = await getAllFeedbacks();
    return Future.value(true);
  }

  Future<bool> dislikeAFeedback(int feedbackid) async {
    // placeholder
    final allFeedbacksForAnEvent = await getAllFeedbacks();
    return Future.value(true);
  }


  Future<bool> unLikeAFeedback(int feedbackid) async {
    // placeholder
    final allFeedbacksForAnEvent = await getAllFeedbacks();
    return Future.value(true);
  }

  Future<bool> unDislikeAFeedback(int feedbackid) async {
    // placeholder
    final allFeedbacksForAnEvent = await getAllFeedbacks();
    return Future.value(true);
  }
  Future<bool> makeAFeedback(Feedback feedback) async {
    // placeholder
    final allFeedbacksForAnEvent = await getAllFeedbacks();
    return Future.value(true);
  }
   Future<bool> updateAFeedback(int feedbackid,Feedback feedback) async {
    // placeholder
    final allFeedbacksForAnEvent = await getAllFeedbacks();
    return Future.value(true);
  }

   Future<bool> deleteAFeedback(int feedbackid) async {
    // placeholder
    final allFeedbacksForAnEvent = await getAllFeedbacks();
    return Future.value(true);
  }

}
