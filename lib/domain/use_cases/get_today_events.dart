import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class GetTodayEventsUseCase {
  final EventRepository repository;

  GetTodayEventsUseCase(this.repository);

  Future<List<Event>> call() async {
    return await repository.getEventsForToday();
  }
}
