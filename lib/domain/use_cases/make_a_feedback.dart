import 'package:confhub/domain/entities/feedback.dart';
import 'package:confhub/domain/repositories/feedback_repository.dart';

class MakeAFeedbackUseCase {
  final FeedbackRepository repository;

  MakeAFeedbackUseCase(this.repository);

  Future<Feedback?> call (Feedback feedback) async {
    return await repository.makeAFeedback(feedback);
  }
}