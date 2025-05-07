import 'dart:convert';

import 'dart:developer';


import 'package:confhub/data/models/feedback_model.dart';
import 'package:confhub/core/utils/filter_feedbacks.dart';

import 'package:http/http.dart' as http;

class FeedbackRemoteDataSource {
  final String baseUrl = "http://localhost:3000/api/feedbacks";

  final headers = {'Content-Type': 'application/json'};
  
  Future<List<FeedbackModel>> getAllFeedbacks() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => FeedbackModel.fromJson(json)).toList();
      } catch (error) {
        throw Exception('${json.decode(response.body)}');
      }
    } else {
      throw Exception('Error cargando feedbacks desde API');
    }
  }

  Future<bool> likeAFeedback(int feedbackid) async {
    final response = await http.patch(Uri.parse("$baseUrl/like/$feedbackid"));

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> dislikeAFeedback(int feedbackid) async {
    final response =
        await http.patch(Uri.parse("$baseUrl/dislike/$feedbackid"));

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> unLikeAFeedback(int feedbackid) async {
    final response = await http.patch(Uri.parse("$baseUrl/unlike/$feedbackid"));

    if (response.statusCode == 200) {
      log(response.body);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> unDislikeAFeedback(int feedbackid) async {
    final response =
        await http.patch(Uri.parse("$baseUrl/undislike/$feedbackid"));

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<FeedbackModel?> makeAFeedback(Feedback feedback) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: headers,
        body: json.encode({
          "eventid": feedback.eventid,
          "title": feedback.title,
          "comment": feedback.comment,
          "score": feedback.score
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final feedbackMade = data['feedbackMade'];
      return FeedbackModel.fromJson(feedbackMade);
    } else {
      return null;
    }
  }

  Future<bool> updateAFeedback(int feedbackid, Feedback feedback) async {
    final response = await http.patch(Uri.parse("$baseUrl/$feedbackid"),
        headers: headers,
        body: json.encode({
          "eventid": feedback.eventid,
          "title": feedback.title,
          "comment": feedback.comment,
          "score": feedback.score
        }));

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> deleteAFeedback(int feedbackid) async {
    final response = await http.delete(Uri.parse("$baseUrl/$feedbackid"));

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  // Obtener feedbacks de un evento
  Future<List<FeedbackModel>> getAllFeedbacksFromAnEvent(
      int eventId, String filtro) async {
    final url = Uri.parse("$baseUrl/$eventId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<FeedbackModel> feedbacks =
            data.map((json) => FeedbackModel.fromJson(json)).toList();
        // Aplicar filtro y ordenamiento
        return filterAndSortFeedbacks(feedbacks, filtro);
      } else {
        throw Exception(
            "Error al obtener feedbacks del evento: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al conectar con la API: $e");
    }
  }

}