import 'dart:developer';

import 'package:hive/hive.dart';
import '../models/event_model.dart';

class EventLocalDataSource {
  static const String eventsBoxName = 'events';
  static const String feedbacksBoxName = 'feedbacks';
  static const String apiVersionBoxName = 'api_version';

  // Guardar eventos
  Future<void> saveEvents(List<EventModel> events) async {
    final box = await Hive.openBox(eventsBoxName);
    await box.clear(); // Limpia los eventos existentes
    log("GUARDANDO EVENTOS EN LOCAL");
    for (var event in events) {
      await box.put(event.eventid, event.toJson());
    }
  }

  // Obtener todos los eventos
  Future<List<EventModel>> getAllEvents() async {
    final box = await Hive.openBox(eventsBoxName);
    return box.values.map((json) => EventModel.fromJson(json)).toList();
  }

  // Guardar feedback
  Future<void> saveFeedback(
    int eventId,
    String title,
    String comment,
    double score,
    String datetime,
    int likes,
    int dislikes,
    String? answer,
  ) async {

    final box = await Hive.openBox(feedbacksBoxName);
    await box.add({
      'eventid': eventId,
      'title': title,
      'comment': comment,
      'score': score,
      'datetime': datetime,
      'likes': likes,
      'dislikes': dislikes,
      'answer': answer,
      'isPublished': 0,
    });
  }

  // Obtener feedbacks no publicados
  Future<List<Map<String, dynamic>>> getUnpublishedFeedbacks() async {
    final box = await Hive.openBox(feedbacksBoxName);
    return box.values
        .where((feedback) => feedback['isPublished'] == 0)
        .cast<Map<String, dynamic>>()
        .toList();
  }

  Future<void> markFeedbackAsPublished(int feedbackId) async {
    final box = await Hive.openBox(feedbacksBoxName);

    // Buscar el feedback por su ID
    final feedbackKey = box.keys.firstWhere(
      (key) => box.get(key)['feedbackid'] == feedbackId,
      orElse: () => null,
    );

    if (feedbackKey != null) {
      // Actualizar el campo 'isPublished' a 1
      final feedback = box.get(feedbackKey);
      feedback['isPublished'] = 1;
      await box.put(feedbackKey, feedback);
    }
  }

  // Guardar la versión de la API
  Future<void> saveApiVersion(String version) async {
    final box = await Hive.openBox(apiVersionBoxName);
    await box.put('version', version);
  }

  // Obtener la versión de la API
  Future<String?> getApiVersion() async {
    final box = await Hive.openBox(apiVersionBoxName);
    return box.get('version');
  }
}
