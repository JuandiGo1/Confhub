import 'package:confhub/data/models/feedback_model.dart';
import 'package:confhub/domain/entities/feedback.dart';

abstract class FeedbackRepository {
  Future<List<Feedback>> getAllFeedbacks();

  Future<List<Feedback>> getAllFeedbacksFromAnEvent(int eventid, String filtro);

  Future<bool> sendFeedback(feedback);

  Future<bool> likeAFeedback(int eventid);

  Future<bool> dislikeAFeedback(int eventid);

  Future<bool> unLikeAFeedback(int feedbackid);

  Future<bool> unDislikeAFeedback(int feedbackid);

  Future<bool> updateAFeedback(int feedbackid, feedback);

  Future<bool> deleteAFeedback(int feedbackid);

  Future<FeedbackModel?> makeAFeedback(feedback);
}
