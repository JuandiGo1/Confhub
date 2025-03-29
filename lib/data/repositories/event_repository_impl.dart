//Aca implementamos la funcionalidad de los metodos necesarios con la data: obtener eventos, podria ser añadir, elmininar, actualizar etc

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
      throw Exception('Error obteniendo eventos: $e');
    }
  }

  @override
  Future<List<EventModel>> getEventsForToday() async {
    try {
      return await localDataSource.getEventsForToday();
    } catch (e) {
      throw Exception('Error obteniendo eventos de hoy: $e');
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
}
