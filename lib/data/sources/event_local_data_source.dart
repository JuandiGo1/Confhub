import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/event_model.dart';

class EventLocalDataSource {
  Future<List<EventModel>> getAllEvents() async {
    final String response = await rootBundle.loadString('data/events.json');
    final List<dynamic> data = json.decode(response);

    return data.map((json) => EventModel.fromJson(json)).toList();
  }
}
