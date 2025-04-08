import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class GetSuscribedEventsUseCase {
  final EventRepository repository;

  GetSuscribedEventsUseCase(this.repository);

  Future<List<Event>> call() async {
    final events = await repository.getSubscribedEventsInDateRange(DateTime.now().subtract(Duration(days: 60)), DateTime.now().add(Duration(days: 60)));
    events.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return events;
  }
}

