import 'dart:convert';
import 'dart:developer';
import 'package:confhub/core/utils/date_formatter.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventRemoteDataSource {
  final String baseUrl = "http://localhost:3000/api/events";
  final EventLocalDataSource localDataSource;

  EventRemoteDataSource({required this.localDataSource});

  Future<List<EventModel>> getAllEvents() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      log("Datos recibidos desde la API");
      final apiVersion = await getApiVersion();
      final localApiVersion = await localDataSource.getApiVersion();

      //Solo actualizar si hay cambios

      await localDataSource.saveEvents(data);
      log("Eventos guardados en local");

      return data.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception('Error cargando eventos desde API');
    }
  }

  Future<List<EventModel>> getEventsForToday() async {
    try {
      final allEvents = await getAllEvents();
      final today = formatDate(DateTime.now());

      return allEvents.where((event) {
        return event.date == today; // Compara las fechas formateadas
      }).toList();
    } catch (e) {
      log("Error obteniendo eventos del día: $e");
      log("Filtrando eventos locales para el día de hoy...");
      final allEvents = await localDataSource.getAllEvents();
      final today = formatDate(DateTime.now());

      return allEvents.where((event) {
        return event.date == today; // Compara las fechas formateadas
      }).toList();
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final allEvents = await getAllEvents();
      Set<String> categories = {};

      for (var event in allEvents) {
        categories.add(event.category);
      }

      return categories.toList();
    } catch (e) {
      log("Error obteniendo categorías remotas: $e");
      log("Cargando categorías desde eventos locales...");
      final allEvents = await localDataSource.getAllEvents();
      Set<String> categories = {};

      for (var event in allEvents) {
        categories.add(event.category);
      }

      return categories.toList();
    }
  }

  Future<List<EventModel>> getEventsByCategory(String category) async {
    try {
      final allEvents = await getAllEvents();

      return allEvents.where((event) {
        return event.category == category;
      }).toList();
    } catch (e) {
      log("Error obteniendo eventos por categoría: $e");
      log("Filtrando eventos locales por categoría...");
      final allEvents = await localDataSource.getAllEvents();

      return allEvents.where((event) {
        return event.category == category;
      }).toList();
    }
  }

  List<int> subscribedEventIds = [];

  Future<void> fetchSubscribedEvents() async {
    final url = Uri.parse("http://localhost:3000/api/subscribed/");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        subscribedEventIds = List<int>.from(data);
        // Guardar los eventos suscritos localmente
        await localDataSource.saveSubscribedEvents(subscribedEventIds);
        log("Eventos suscritos sincronizados con el servidor y guardados localmente.");
      } else {
        throw Exception('No se pudieron cargar las suscripciones');
      }
    } catch (e) {
      log("Error obteniendo suscripciones remotas: $e");
      log("Cargando suscripciones desde almacenamiento local...");
      subscribedEventIds = await localDataSource.getSubscribedEventIds();
    }
  }

  Future<bool> subscribeAnEvent(int eventId) async {
    final url = Uri.parse("$baseUrl/subscribe/$eventId");

    try {
      log("Calling subscribe event with id $eventId");
      final response = await http.patch(url);
      log("Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        subscribedEventIds.add(eventId);
        await localDataSource.saveSubscribedEvent(eventId); // Guardar en local
        return true;
      } else if (response.statusCode == 400) {
        return false; // Ya suscrito
      } else {
        throw Exception('Error al suscribirse al evento');
      }
    } catch (e) {
      log("Error al suscribirse al evento: $e");
      log("Guardando suscripción localmente...");
      subscribedEventIds.add(eventId);
      await localDataSource.saveSubscribedEvent(eventId); // Guardar en local
      return true;
    }
  }

  bool isSubscribed(int eventId) {
    return subscribedEventIds.contains(eventId);
  }

  Future<bool> unsubscribeFromEvent(int eventId) async {
    log("Calling unsubscribe event with id $eventId");
    final url = Uri.parse("$baseUrl/unsubscribe/$eventId");

    try {
      final response = await http.patch(url);

      if (response.statusCode == 200) {
        subscribedEventIds.remove(eventId);
        await localDataSource.removeSubscribedEvent(eventId);
        return true;
      } else {
        throw Exception('Error al desuscribirse del evento');
      }
    } catch (e) {
      log("Error al desuscribirse del evento: $e");
      log("Guardando desuscripción localmente...");
      subscribedEventIds.remove(eventId);
      await localDataSource.removeSubscribedEvent(eventId); // Guardar en local
      return true;
    }
  }

  Future<String> getApiVersion() async {
    final url = Uri.parse("http://localhost:3000/apiVersion");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['apiVersion'];
      } else {
        throw Exception(
            'Error al obtener la versión de la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error al conectar con la API: $e");
    }
  }
}
