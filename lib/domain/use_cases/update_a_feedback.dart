import 'package:confhub/domain/entities/feedback.dart';
import 'package:confhub/domain/repositories/feedback_repository.dart';

class UpdateAFeedbackUseCase {
  final FeedbackRepository repository;

UpdateAFeedbackUseCase(this.repository);

  Future<bool> call (int feedbackid, feedback) async {
    return await repository.updateAFeedback(feedbackid,feedback);
  }
}