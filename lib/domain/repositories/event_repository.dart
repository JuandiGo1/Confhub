//Aca solo definimos los metodos necesarios, su funcionalidad se define en data/repositories/event_repository_impl

import 'package:confhub/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getAllEvents();

  Future<List<Event>> getEventsForToday();

  Future<bool> subscribeAnEvent(int eventid);
}
