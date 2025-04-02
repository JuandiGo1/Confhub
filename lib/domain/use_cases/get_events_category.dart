import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class GetEventsByCategory {
  final EventRepository repository;

  GetEventsByCategory(this.repository);

  Future<List<Event>> call(String category) async {
    return await repository.getEventsByCategory(category);
  }
}