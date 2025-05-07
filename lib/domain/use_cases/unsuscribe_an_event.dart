
import 'package:confhub/domain/repositories/event_repository.dart';

class UnsubscribeEventUseCase {
  final EventRepository repository;

  UnsubscribeEventUseCase(this.repository);

  Future<bool> call(int eventId) async {
    return await repository.unsubscribeFromEvent(eventId);
  }
}