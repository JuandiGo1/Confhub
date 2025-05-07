import 'package:confhub/domain/entities/feedback.dart';

abstract class FeedbackRepository {
  Future<List<Feedback>> getAllFeedbacks();

  Future<List<Feedback>> getAllFeedbacksFromAnEvent(int eventid, String filtro);

  Future<bool> likeAFeedback(int eventid);

  Future<bool> dislikeAFeedback(int eventid);
}
