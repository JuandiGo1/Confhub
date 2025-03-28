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
}
