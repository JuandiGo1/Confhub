// ignore: unused_import
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

class SubscribeAnEventUseCase {
  final EventRepository repository;

  SubscribeAnEventUseCase(this.repository);

  Future<bool> call(int eventid) async {
    return await repository.subscribeAnEvent(eventid);
  }
}