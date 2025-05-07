import 'dart:developer';

import 'package:hive/hive.dart';
import '../models/event_model.dart';

class EventLocalDataSource {
  static const String eventsBoxName = 'events';
  static const String feedbacksBoxName = 'feedbacks';
  static const String apiVersionBoxName = 'api_version';
  static const String subscribedEventsBoxName = 'subscribed_events';

  // Guardar eventos
  Future<void> saveEvents(List<dynamic> rawEvents) async {
    final box = await Hive.openBox(eventsBoxName);
    await box.clear(); // Limpia los eventos existentes
    log("VAMOS A GUARDAR LOS EVENTOS EN LOCAL: ${rawEvents.length}");
    for (var rawEvent in rawEvents) {
      try {
        // Guardar los datos crudos directamente como JSON
        final eventId = rawEvent['eventid'];
        await box.put(eventId, rawEvent);
      } catch (e) {
        log("Error al guardar el evento: $e");
      }
    }
  }

  // Obtener todos los eventos
  Future<List<EventModel>> getAllEvents() async {
    final box = await Hive.openBox(eventsBoxName);

    // Log para verificar si el box se abre correctamente
    log("Box '$eventsBoxName' abierto. Contiene ${box.length} elementos.");

    // Log para inspeccionar los datos crudos en el box
    // for (var key in box.keys) {
    //   log("Clave: $key, Valor: ${box.get(key)}");
    // }

    try {
      // Intentar deserializar los datos
      final events = box.values
          .map((json) => EventModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();

      log("Eventos deserializados correctamente: ${events.length}");
      return events;
    } catch (e) {
      // Log para capturar errores de deserialización
      log("Error al deserializar eventos locales: $e");
      return [];
    }
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

  Future<void> saveSubscribedEvent(int eventId) async {
    final box = await Hive.openBox(subscribedEventsBoxName);
    await box.put(eventId, true); // Guardar el evento como suscrito
  }

  Future<void> removeSubscribedEvent(int eventId) async {
    final box = await Hive.openBox(subscribedEventsBoxName);
    await box.delete(eventId); // Eliminar el evento de las suscripciones
    log("Evento desuscrito eliminado localmente: $eventId");
  }

  Future<void> saveSubscribedEvents(List<int> subscribedEventIds) async {
    final box = await Hive.openBox(subscribedEventsBoxName);
    await box.clear(); // Limpia las suscripciones existentes
    for (var eventId in subscribedEventIds) {
      await box.put(eventId, true); // Guardar cada ID como suscrito
    }
    log("Eventos suscritos guardados localmente: $subscribedEventIds");
  }

  Future<List<int>> getSubscribedEventIds() async {
    final box = await Hive.openBox(subscribedEventsBoxName);
    return box.keys
        .cast<int>()
        .toList(); // Devolver las claves como IDs de eventos
  }

  // Guardar la versión de la API
  Future<void> saveApiVersion(String version) async {
    log("APIVERSION Guardada $version");
    final box = await Hive.openBox(apiVersionBoxName);
    await box.put('version', version);
  }

  // Obtener la versión de la API
  Future<String?> getApiVersion() async {
    final box = await Hive.openBox(apiVersionBoxName);
    return box.get('version');
  }
}
