import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class GetAllEventsUseCase {
  final EventRepository repository;

  GetAllEventsUseCase(this.repository);

  Future<List<Event>> call() async {
    return await repository.getAllEvents();
  }
}
