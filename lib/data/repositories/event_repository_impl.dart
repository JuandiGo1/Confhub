//Aca implementamos la funcionalidad de los metodos necesarios con la data: obtener eventos, podria ser añadir, elmininar, actualizar etc

import 'dart:developer';

import 'package:confhub/data/models/event_model.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/data/sources/event_remote_data_source.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl(this.remoteDataSource, this.localDataSource);

  Future<void> loadSubscribedEvents() async {
    try {
      await remoteDataSource.fetchSubscribedEvents();
    } catch (e) {
      log("Error cargando eventos suscritos: $e");
    }
  }

  @override
  Future<List<EventModel>> getAllEvents() async {
    try {
      final events = await remoteDataSource.getAllEvents();
      
      return events;
    } catch (e) {
      log('Error obteniendo eventos remotos: $e');
      final eventsLocal = await localDataSource.getAllEvents();
      if (eventsLocal.isEmpty) {
        log("No hay eventos locales disponibles.");
      } else {
        log("Eventos locales cargados: ${eventsLocal.length}");
      }
      return eventsLocal;
    }
  }

  @override
  Future<List<EventModel>> getSubscribedEventsInDateRange(
      DateTime startDate, DateTime endDate) async {
    try {
      final allEvents = await remoteDataSource.getAllEvents();
      final subscribedIds = remoteDataSource.subscribedEventIds;

      log("Subscribed IDs: $subscribedIds");

      return allEvents.where((event) {
        final eventDate = event.dateTime;
        return subscribedIds.contains(event.eventid) &&
            eventDate.isAfter(startDate) &&
            eventDate.isBefore(endDate);
      }).toList();
    } catch (e) {
      log('Error obteniendo eventos suscritos en el rango de fechas: $e');
      return [];
    }
  }

  @override
  Future<bool> subscribeAnEvent(int eventid) async {
    try {
      log("Vamos a subscribir al evento con ID: $eventid");
      return await remoteDataSource.subscribeAnEvent(eventid);
    } catch (e) {
      throw Exception('Error subscribiendo: $e');
    }
  }

  @override
  Future<bool> unsubscribeFromEvent(int eventId) async {
    return await remoteDataSource.unsubscribeFromEvent(eventId);
  }

  @override
  Future<bool> isSubscribed(int eventId) async {
    return remoteDataSource.isSubscribed(eventId);
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

  //Metodos BD local
  @override
  Future<void> saveEvents(List<EventModel> events) async {
    await localDataSource.saveEvents(events);
  }

  @override
  Future<List<Map<String, dynamic>>> getUnpublishedFeedbacks() async {
    return await localDataSource.getUnpublishedFeedbacks();
  }

  @override
  Future<void> markFeedbackAsPublished(int feedbackId) async {
    await localDataSource.markFeedbackAsPublished(feedbackId);
  }

  @override
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
    await localDataSource.saveFeedback(
      eventId,
      title,
      comment,
      score,
      datetime,
      likes,
      dislikes,
      answer,
    );
  }
}
