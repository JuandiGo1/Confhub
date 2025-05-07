
import 'package:confhub/domain/repositories/feedback_repository.dart';

class LikeAFeedbackUseCase {
  final FeedbackRepository repository;

  LikeAFeedbackUseCase(this.repository);

  Future<bool> call (int feedbackid) async {
    return await repository.likeAFeedback(feedbackid);
  }
}