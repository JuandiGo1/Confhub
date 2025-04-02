import 'package:confhub/domain/repositories/event_repository.dart';

class GetCategories {
  final EventRepository repository;

  GetCategories(this.repository);

  Future<List<String>> call() async {
    return await repository.getCategories();
  }
}