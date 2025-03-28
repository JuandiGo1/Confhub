//Aca solo definimos los metodos necesarios, su funcionalidad se define en data/repositories/event_repository_impl

import 'package:confhub/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getAllEvents();
}

