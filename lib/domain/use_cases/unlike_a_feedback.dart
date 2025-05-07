import 'package:confhub/domain/repositories/feedback_repository.dart';

class UnLikeAFeedbackUseCase {
  final FeedbackRepository repository;

  UnLikeAFeedbackUseCase(this.repository);

  Future<bool> call (int feedbackid) async {
    return await repository.unLikeAFeedback(feedbackid);
  }
}