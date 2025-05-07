//Aca implementamos la funcionalidad de los metodos necesarios con la data: obtener eventos, podria ser añadir, elmininar, actualizar etc

import 'dart:developer';

import 'package:confhub/data/models/event_model.dart';
//import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/data/sources/event_remote_data_source.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  //final EventLocalDataSource localDataSource;
  final EventRemoteDataSource remoteDataSource;

  final List<int> _subscribedEvents = []; // In-memory cache

  EventRepositoryImpl(this.remoteDataSource);



  @override
  Future<List<EventModel>> getAllEvents() async {
    try {
      final events =await remoteDataSource.getAllEvents();
      return events;
    } catch (e) {
      log('Error obteniendo eventos: $e');
      return [];
    }
  }

  @override
  Future<List<EventModel>> getSubscribedEventsInDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final allEvents = await remoteDataSource.getAllEvents();
      log("$_subscribedEvents");
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
      return await remoteDataSource.getEventsForToday();
    } catch (e) {
      log('Error obteniendo eventos de hoy: $e');
      return [];
    }
  }

  @override
  Future<List<String>> getCategories() async {
    return await remoteDataSource.getCategories();
  }

  @override
  Future<List<EventModel>> getEventsByCategory(String category) async {
    return await remoteDataSource.getEventsByCategory(category);
  }

  @override
  Future<bool> subscribeAnEvent(int eventid) async {
    try {
      return await remoteDataSource.subscribeAnEvent(eventid);
    } catch (e) {
      throw Exception('Error subscribiendo: $e');
    }
  }
}
