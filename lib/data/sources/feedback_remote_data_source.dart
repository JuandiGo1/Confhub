import 'dart:convert';
import 'package:confhub/data/models/feedback_model.dart';
import 'package:confhub/core/utils/filter_feedbacks.dart';
import 'package:http/http.dart' as http;

class FeedbackRemoteDataSource {
  final String baseUrl = "http://localhost:3000/api/feedbacks";

  // Obtener todos los feedbacks
  Future<List<FeedbackModel>> getAllFeedbacks() async {
    final url = Uri.parse(baseUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => FeedbackModel.fromJson(json)).toList();
      } else {
        throw Exception("Error al obtener feedbacks: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al conectar con la API: $e");
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

  // Dar like a un feedback
  Future<bool> likeAFeedback(int eventid) async {
    final url = Uri.parse("$baseUrl/like/$eventid");
    try {
      final response = await http.patch(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Error al dar like: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al conectar con la API: $e");
    }
  }

  // Dar dislike a un feedback
  Future<bool> dislikeAFeedback(int eventid) async {
    final url = Uri.parse("$baseUrl/dislike/$eventid");

    try {
      final response = await http.patch(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Error al dar dislike: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al conectar con la API: $e");
    }
  }

  // Enviar/agregar un feedback
  Future<bool> sendFeedback(feedback) async {
    final url =
        Uri.parse(baseUrl); // Cambia la URL según tu API

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'eventid': feedback.eventid,
          'comment': feedback.comment,
          'title': feedback.title,
          'score': feedback.score,
          'likes': feedback.likes,
          'dislikes': feedback.dislikes,
          'answer': feedback.answer,
          'answerDateTime': feedback.answerDateTime,
        }),
      );

      if (response.statusCode == 200) {
        return true; // Feedback enviado con éxito
      } else {
        throw Exception("Error al enviar feedback: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al conectar con la API: $e");
    }
  }
}
