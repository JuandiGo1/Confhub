import 'dart:convert';
import 'package:confhub/core/utils/date_formatter.dart';
import 'package:flutter/services.dart';
import '../models/event_model.dart';

class EventLocalDataSource {
  Future<List<EventModel>> getAllEvents() async {
    final String response = await rootBundle.loadString('data/events.json');

    final List<dynamic> data = json.decode(response);

    return data.map((json) => EventModel.fromJson(json)).toList();
  }

  // Nueva función para obtener eventos en la fecha actual
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
      return event.category == category; // Compara las fechas formateadas
    }).toList();
  }

  Future<bool> subscribeAnEvent(int eventid) async {
    try {
      final allEvents = await getAllEvents();
      final eventsubs = allEvents.firstWhere((event) {
        return event.eventid == eventid;
      });

      eventsubs.attendees += 1;
      eventsubs.availableSpots -= 1;
      allEvents[allEvents.indexOf(eventsubs)] = eventsubs;

      final List<dynamic> data =
          allEvents.map((event) => event.toJson()).toList();

      final String eventsString = jsonEncode(data);

      await EventModel.saveStringToJsonFile(eventsString, "assets/data/events.json");
      return Future.value(true);
    } catch (e) {
      //return Future.value(false);
      throw Exception("Hubo un problema: $e");
    }

  }
}
