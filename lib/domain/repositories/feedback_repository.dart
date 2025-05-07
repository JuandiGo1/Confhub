import 'package:confhub/domain/entities/feedback.dart';

abstract class FeedbackRepository {
  Future<List<Feedback>> getAllFeedbacks();

  Future<List<Feedback>> getAllFeedbacksFromAnEvent(int eventid, String filtro);

  Future<bool> likeAFeedback(int feedbackid);

  Future<bool> dislikeAFeedback(int feedbackid);

  Future<bool> unLikeAFeedback(int feedbackid);

  Future<bool> unDislikeAFeedback(int feedbackid);

  Future<Feedback?> makeAFeedback(Feedback feedback);

  Future<bool> updateAFeedback(int feedbackid, Feedback feedback);

  Future<bool> deleteAFeedback(int feedbackid);
}
