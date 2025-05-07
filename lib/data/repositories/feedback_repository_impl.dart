import 'dart:developer';

import 'package:confhub/data/models/feedback_model.dart';
import 'package:confhub/data/sources/feedback_remote_data_source.dart';
import 'package:confhub/domain/entities/feedback.dart';
import 'package:confhub/domain/repositories/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {

  final FeedbackRemoteDataSource remoteDataSource;

  FeedbackRepositoryImpl(this.remoteDataSource);


  @override
  Future<List<Feedback>> getAllFeedbacks() async {
    try {
      return await remoteDataSource.getAllFeedbacks();
    } catch (e) {
      log('Error obteniendo Feedbacks: $e');
      return <Feedback>[];
    }
  }

  @override
  Future<List<Feedback>> getAllFeedbacksFromAnEvent(
      int eventid, String filtro) async {
    try {
      return await remoteDataSource.getAllFeedbacksFromAnEvent(eventid, filtro);
    } catch (e) {
      log('Error obteniendo Feedbacks: $e');
      return <Feedback>[];
    }
  }

  @override
  Future<bool> likeAFeedback(int eventid) async {
    try {
      return await remoteDataSource.likeAFeedback(eventid);
    } catch (e) {
      log('Error obteniendo Feedbacks: $e');
      return Future.value(true);
    }
  }

  @override
  Future<bool> dislikeAFeedback(int eventid) async{
        try {
      return await remoteDataSource.dislikeAFeedback(eventid);
    } catch (e) {
      log('Error obteniendo Feedbacks: $e');
      return Future.value(true);
    }
  }


// code from edi

 @override
  Future<bool> unDislikeAFeedback(int feedbackid) async {
    try {
      return await remoteDataSource.unDislikeAFeedback(feedbackid);
    } catch (e) {
      log('Error undislikeando Feedback: $e');
      return Future.value(false);
    }
  }

  @override
  Future<bool> unLikeAFeedback(int feedbackid) async {
    try {
      return await remoteDataSource.unLikeAFeedback(feedbackid);
    } catch (e) {
      log('Error unlikeando Feedback: $e');
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteAFeedback(int feedbackid) async {
       try {
      return await remoteDataSource.deleteAFeedback(feedbackid);
    } catch (e) {
      log('Error eliminando Feedbacks: $e');
      return Future.value(false);
    }
  }

  @override
  Future<bool> sendFeedback(feedback) async {
      try {
      return await remoteDataSource.sendFeedback(feedback);
    } catch (e) {
      log('Error registrando Feedback: $e');
      return Future.value(false);
    }
  }

  @override
  Future<bool> updateAFeedback(int feedbackid,feedback) async {
       try {
      return await remoteDataSource.updateAFeedback(feedbackid, feedback);
    } catch (e) {
      log('Error actualizando Feedback: $e');
      return Future.value(false);
    }
  }

  @override
  Future<FeedbackModel?> makeAFeedback(feedback) async {
      try {
      return await remoteDataSource.makeAFeedback(feedback);
    } catch (e) {
      log('Error registrando Feedback: $e');
      return null;
    }
  }

}