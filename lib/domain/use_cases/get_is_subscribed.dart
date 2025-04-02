import 'package:confhub/domain/repositories/event_repository.dart';

class IsSubscribed {
  final EventRepository repository;

  IsSubscribed(this.repository);

  Future<bool> call(int eventId) async {
    return await repository.isSubscribed(eventId);
  }
}
