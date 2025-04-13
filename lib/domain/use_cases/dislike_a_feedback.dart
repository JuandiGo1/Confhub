
import 'package:confhub/domain/repositories/feedback_repository.dart';

class DislikeAFeedbackUseCase {
  final FeedbackRepository repository;

  DislikeAFeedbackUseCase(this.repository);

  Future<bool> call (int eventid) async {
    return await repository.dislikeAFeedback(eventid);
  }
}