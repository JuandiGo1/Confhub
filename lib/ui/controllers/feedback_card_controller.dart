import 'dart:developer';

import 'package:confhub/data/sources/shared_prefs/local_preferences.dart';
import 'package:confhub/domain/use_cases/dislike_a_feedback.dart';
import 'package:confhub/domain/use_cases/like_a_feedback.dart';
import 'package:confhub/domain/use_cases/undislike_a_feedback.dart';
import 'package:confhub/domain/use_cases/unlike_a_feedback.dart';
import 'package:get/get.dart';

class FeedbackCardController extends GetxController {
  final int initialLikes;
  final int initialDislikes;
  final int eventid;
  final int feedbackid;

  final RxInt _likes = 0.obs;
  final RxInt _dislikes = 0.obs;
  final RxBool _statuslike = false.obs;
  final RxBool _statusdislike = false.obs;

  String get likes => _likes.value.toString();
  String get dislikes => _dislikes.value.toString();

  FeedbackCardController(
      {required this.initialLikes,
      required this.initialDislikes,
      required this.eventid,
      required this.feedbackid});

  @override
  void onInit() async {
    super.onInit();
    _likes.value = initialLikes;
    _dislikes.value = initialDislikes;
    final local = LocalPreferences();
    final estado = await local.retrieveData<bool>("$feedbackid/$eventid/like");
    final estado2 =
        await local.retrieveData<bool>("$feedbackid/$eventid/dislike");
    _statuslike.value = estado ?? false;
    _statusdislike.value = estado2 ?? false;
  }

  bool isLiked() => (initialLikes < _likes.value) || _statuslike.value;
  bool isDisliked() =>
      (initialDislikes < _dislikes.value) || _statusdislike.value;

  Future<bool> likeAFeedback(int eventid) async {
    final local = LocalPreferences();
    log("${_statuslike.value}, ${_statusdislike.value}" );
    if (isDisliked()) {
      final usecase3 = Get.find<UnDisLikeAFeedbackUseCase>();
      await usecase3.call(feedbackid);
      _dislikes.value -= 1;
      await local.storeData("$feedbackid/$eventid/dislike", false);
      if (_statusdislike.value) _statusdislike.value = false;
    }

    final usecase = Get.find<LikeAFeedbackUseCase>();
    final usecase2 = Get.find<UnLikeAFeedbackUseCase>();
    if (!isLiked()) {
      final result = await usecase.call(feedbackid);
      if (result) {
        _likes.value += 1;
        await local.storeData("$feedbackid/$eventid/like", true);
        if (!_statuslike.value) _statuslike.value = true;
      }
      return Future.value(result);
    } else if (isLiked()) {
      final result = await usecase2.call(feedbackid);
      if (result) {
        _likes.value -= 1;
        await local.storeData("$feedbackid/$eventid/like", false);
        if (_statuslike.value) _statuslike.value = false;
      }
      return Future.value(result);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> dislikeAFeedback(int eventid) async {
    final local = LocalPreferences();

    if (isLiked()) {
      final usecase3 = Get.find<UnLikeAFeedbackUseCase>();
      await usecase3.call(feedbackid);
      _likes.value -= 1;
      await local.storeData("$feedbackid/$eventid/like", false);
      if (_statuslike.value) _statuslike.value = false;
    }

    final usecase = Get.find<DislikeAFeedbackUseCase>();
    final usecase2 = Get.find<UnDisLikeAFeedbackUseCase>();

    if (!isDisliked()) {
      final result = await usecase.call(feedbackid);
      if (result) {
        _dislikes.value += 1;
        await local.storeData("$feedbackid/$eventid/dislike", true);
        if (!_statusdislike.value) _statusdislike.value = true;
      }
      return Future.value(result);
    } else if (isDisliked()) {
      final result = await usecase2.call(feedbackid);
      if (result) {
        _dislikes.value -= 1;
        await local.storeData("$feedbackid/$eventid/dislike", false);
        if (_statusdislike.value) _statusdislike.value = false;
      }
      return Future.value(result);
    } else {
      return Future.value(false);
    }
  }
}
