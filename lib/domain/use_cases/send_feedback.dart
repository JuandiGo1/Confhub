
import 'package:confhub/domain/repositories/feedback_repository.dart';

class SendFeedbackUseCase {
  final FeedbackRepository repository;

  SendFeedbackUseCase(this.repository);

  Future<bool> call (feedback) async {
    return await repository.sendFeedback(feedback);
  }
}