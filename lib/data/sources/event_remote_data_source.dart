import 'dart:convert';
import 'package:confhub/core/utils/date_formatter.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventRemoteDataSource {
  final String baseUrl = "http://localhost:3000/api/events";

  Future<List<EventModel>> getAllEvents() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception('Error cargando eventos desde API');
    }
  }

  Future<List<EventModel>> getEventsForToday() async {
    final allEvents = await getAllEvents();
    final today = formatDate(DateTime.now());

    // Filtrar eventos cuya fecha coincida con la fecha actual
    return allEvents.where((event) {
      return event.date == today; // Compara las fechas formateadas
    }).toList();
  }

  Future<List<String>> getCategories() async {
    final allEvents = await getAllEvents();
    Set<String> categories = {};

    for (var event in allEvents) {
      categories.add(event.category);
    }

    return categories.toList();
  }

  Future<List<EventModel>> getEventsByCategory(String category) async {
    final allEvents = await getAllEvents();

    return allEvents.where((event) {
      return event.category == category;
    }).toList();
  }

  
  List<int> subscribedEventIds = [];

  Future<void> fetchSubscribedEvents() async {
  final url = Uri.parse("http://localhost:3000/api/subscribed/");

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      subscribedEventIds = List<int>.from(data);
    } else {
      throw Exception('No se pudieron cargar las suscripciones');
    }
  } catch (e) {
    throw Exception("Error al obtener suscripciones: $e");
  }
}


  Future<bool> subscribeAnEvent(int eventId) async {
    final url = Uri.parse("$baseUrl/subscribe/$eventId");

    try {
      print("Calling subscribe event with id $eventId");
      final response = await http.patch(url);
      print("Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        subscribedEventIds.add(eventId);
        return true;
      } else if (response.statusCode == 400) {
        return false; // Ya suscrito
      } else {
        throw Exception('Error al suscribirse al evento');
      }
    } catch (e) {
      throw Exception("Hubo un problema: $e");
    }
  }

  bool isSubscribed(int eventId) {
    return subscribedEventIds.contains(eventId);
  }

  Future<bool> unsubscribeFromEvent(int eventId) async {
    print("Calling unsubscribe event with id $eventId");
    final url = Uri.parse("$baseUrl/unsubscribe/$eventId");

    try {
      final response = await http.patch(url);

      if (response.statusCode == 200) {
        subscribedEventIds.remove(eventId);
        return true;
      } else {
        throw Exception('Error al desuscribirse del evento');
      }
    } catch (e) {
      throw Exception("Hubo un problema: $e");
    }
  }
}
