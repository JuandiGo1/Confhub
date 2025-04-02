//Aca implementamos la funcionalidad de los metodos necesarios con la data: obtener eventos, podria ser añadir, elmininar, actualizar etc

import 'dart:developer';

import 'package:confhub/data/models/event_model.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;

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
  Future<List<EventModel>> getEventsForToday() async {
    try {
      return await localDataSource.getEventsForToday();
    } catch (e) {
      log('Error obteniendo eventos de hoy: $e');
      return [];
    }
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
