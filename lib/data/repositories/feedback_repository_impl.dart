import 'dart:developer';

import 'package:confhub/data/sources/feedback_local_data_source.dart';
import 'package:confhub/domain/entities/feedback.dart';
import 'package:confhub/domain/repositories/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackLocalDataSource localDataSource;

  FeedbackRepositoryImpl(this.localDataSource);

  @override
  Future<List<Feedback>> getAllFeedbacks() async {
    try {
      return await localDataSource.getAllFeedbacks();
    } catch (e) {
      log('Error obteniendo Feedbacks: $e');
      return <Feedback>[];
    }
  }

  @override
  Future<List<Feedback>> getAllFeedbacksFromAnEvent(
      int eventid, String filtro) async {
    try {
      return await localDataSource.getAllFeedbacksFromAnEvent(eventid, filtro);
    } catch (e) {
      log('Error obteniendo Feedbacks: $e');
      return <Feedback>[];
    }
  }
}
