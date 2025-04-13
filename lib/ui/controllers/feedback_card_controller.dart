import 'package:confhub/domain/use_cases/dislike_a_feedback.dart';
import 'package:confhub/domain/use_cases/like_a_feedback.dart';
import 'package:get/get.dart';

class FeedbackCardController extends GetxController {
  final int initialLikes;
  final int initialDislikes;

  final RxInt _likes = 0.obs;
  final RxInt _dislikes = 0.obs;

  String get likes => _likes.value.toString();
  String get dislikes => _dislikes.value.toString();

  FeedbackCardController(
      {required this.initialLikes, required this.initialDislikes});

  @override
  void onInit() {
    super.onInit();
    _likes.value = initialLikes;
    _dislikes.value = initialDislikes;
  }

  bool isLiked() => initialLikes != _likes.value;
  bool isDisliked() => initialDislikes != _dislikes.value;

  Future<bool> likeAFeedback(int eventid) async {
    if (isDisliked()) _dislikes.value -= 1;
    final usecase = Get.find<LikeAFeedbackUseCase>();
    final result = await usecase.call(eventid);
    if (result && !isLiked()) {
      _likes.value += 1;
      return Future.value(true);
    } else if (isLiked()) {
      _likes.value -= 1;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> dislikeAFeedback(int eventid) async {
    if (isLiked()) _likes.value -= 1;
    final usecase = Get.find<DislikeAFeedbackUseCase>();
    final result = await usecase.call(eventid);
    if (result && !isDisliked()) {
      _dislikes.value += 1;
      return Future.value(true);
    } else if (isDisliked()) {
      _dislikes.value -= 1;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
