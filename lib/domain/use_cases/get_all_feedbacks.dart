import 'package:confhub/domain/entities/feedback.dart';
import 'package:confhub/domain/repositories/feedback_repository.dart';

class GetAllFeedbacksUseCase {
  final FeedbackRepository repository;
  GetAllFeedbacksUseCase(this.repository);

  Future<List<Feedback>> call() async {
    return await repository.getAllFeedbacks();
  }
}
