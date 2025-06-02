import 'dart:convert';
import 'dart:developer';
import 'package:confhub/data/models/feedback_model.dart';
import 'package:confhub/core/utils/filter_feedbacks.dart';
import 'package:http/http.dart' as http;

class FeedbackRemoteDataSource {
  final String baseUrl = "https://confhub-backend-production.up.railway.app/api/feedbacks";

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
    final url = Uri.parse("$baseUrl/event/$eventId");

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

  // code from edi

  Future<bool> unLikeAFeedback(int feedbackid) async {
    final response = await http.patch(Uri.parse("$baseUrl/unlike/$feedbackid"));

    if (response.statusCode == 200) {
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

  Future<bool> updateAFeedback(int feedbackid, feedback) async {
    final response = await http.patch(Uri.parse("$baseUrl/$feedbackid"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(feedback));

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

  Future<FeedbackModel?> makeAFeedback(feedback) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(feedback));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final feedbackMade = data['feedbackMade'];
      return FeedbackModel.fromJson(feedbackMade);
    } else {
      return null;
    }
  }

  // Enviar/agregar un feedback
  Future<bool> sendFeedback(feedback) async {
    final url = Uri.parse(baseUrl); 

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
