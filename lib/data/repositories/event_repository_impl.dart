//Aca implementamos la funcionalidad de los metodos necesarios con la data: obtener eventos, podria ser añadir, elmininar, actualizar etc

import 'dart:developer';

import 'package:confhub/data/models/event_model.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;

  final List<int> _subscribedEvents = []; // In-memory cache

  EventRepositoryImpl(this.localDataSource);

  

  @override
  Future<List<EventModel>> getAllEvents() async {
    try {
      return await localDataSource.getAllEvents();
    } catch (e) {
      log('Error obteniendo eventos: $e');
      return [];
    }
  }

  @override
  Future<List<EventModel>> getSubscribedEventsInDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final allEvents = await localDataSource.getAllEvents();
      print(_subscribedEvents);
      return allEvents.where((event) {
        final eventDate = event.dateTime;
        return _subscribedEvents.contains(event.eventid) && eventDate.isAfter(startDate) && eventDate.isBefore(endDate);
      }).toList();
    } catch (e) {
      log('Error obteniendo eventos suscritos en el rango de fechas: $e');
      return [];
    }
  }

  

  @override
  Future<bool> subscribeToEvent(int eventId) async {
    if (!_subscribedEvents.contains(eventId)) {
      _subscribedEvents.add(eventId);
      return true;
    }
    return false;
  }

    @override
  Future<bool> unsubscribeFromEvent(int eventId) async {
    return _subscribedEvents.remove(eventId);
  }

  @override
  Future<bool> isSubscribed(int eventId) async {
    return _subscribedEvents.contains(eventId);
  }

  @override
  Future<List<EventModel>> getEventsForToday() async {
    try {
      return await localDataSource.getEventsForToday();
    } catch (e) {
      log('Error obteniendo eventos de hoy: $e');
      return [];
    }
  }

  @override
  Future<List<String>> getCategories() async {
    return await localDataSource.getCategories();
  }

  @override
  Future<List<EventModel>> getEventsByCategory(String category) async {
    return await localDataSource.getEventsByCategory(category);
  }
  
  @override
  Future<bool> subscribeAnEvent(int eventid) async {
    try {
      return await localDataSource.subscribeAnEvent(eventid);
    } catch (e) {
      throw Exception('Error subscribiendo: $e');
    }
  }
}
