import 'package:confhub/domain/repositories/event_repository.dart';

// subscribe_event_use_case.dart
class SubscribeEventUseCase {
  final EventRepository repository;

  SubscribeEventUseCase(this.repository);

  Future<bool> call(int eventId) async {
    return await repository.subscribeToEvent(eventId);
  }
}