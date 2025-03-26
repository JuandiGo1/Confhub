import '../../domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  @override
  Future<List<String>> getEvents() async {
    return Future.value(["Evento 1", "Evento 2"]);
  }
}
