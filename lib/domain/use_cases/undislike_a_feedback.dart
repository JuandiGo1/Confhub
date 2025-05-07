import 'package:confhub/domain/repositories/feedback_repository.dart';

class UnDisLikeAFeedbackUseCase {
  final FeedbackRepository repository;

  UnDisLikeAFeedbackUseCase(this.repository);

  Future<bool> call (int feedbackid) async {
    return await repository.unDislikeAFeedback(feedbackid);
  }
}