
import 'package:confhub/domain/repositories/feedback_repository.dart';

class  DeleteAFeedbackUseCase {
  final FeedbackRepository repository;

  DeleteAFeedbackUseCase(this.repository);

  Future<bool> call (int feedbackid) async {
    return await repository.deleteAFeedback(feedbackid);
  }
}