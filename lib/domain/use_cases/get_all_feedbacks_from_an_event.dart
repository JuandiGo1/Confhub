import 'package:confhub/domain/entities/feedback.dart';
import 'package:confhub/domain/repositories/feedback_repository.dart';

class GetAllFeedbacksFromAnEventUseCase {
  final FeedbackRepository repository;

  GetAllFeedbacksFromAnEventUseCase(this.repository);

  Future<List<Feedback>> call (int eventid, String filtro) async {
    return await repository.getAllFeedbacksFromAnEvent(eventid, filtro);
  }
}
