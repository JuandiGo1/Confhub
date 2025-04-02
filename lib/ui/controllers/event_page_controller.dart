import 'dart:developer';
import 'package:confhub/domain/use_cases/subscribe_an_event.dart';
import 'package:confhub/domain/use_cases/unsuscribe_an_event.dart';
import 'package:confhub/domain/use_cases/get_is_subscribed.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventPageController extends GetxController {
  final int initialAttendees;
  final int initialSpots;
  final RxInt _attendees = 0.obs;
  final RxInt _spots = 0.obs;
  final RxMap<int, bool> _subscriptionStatus = <int, bool>{}.obs;

  EventPageController({
    required this.initialAttendees,
    required this.initialSpots,
  });

  int get spots => _spots.value;
  int get attendees => _attendees.value;
  String get gspots => _spots.value.toString();
  String get gattendees => _attendees.value.toString();

  @override
  void onInit() {
    super.onInit();
    // Initialize with raw numbers first
    _attendees.value = initialAttendees;
    _spots.value = initialSpots;
  }

  Future<void> initializeForEvent(int eventId) async {
    await checkSubscriptionStatus(eventId);
    // Adjust numbers based on actual subscription status
    if (isSubscribed(eventId)) {
      _attendees.value = initialAttendees + 1;
      _spots.value = initialSpots - 1;
    } else {
      _attendees.value = initialAttendees;
      _spots.value = initialSpots;
    }
    update();
  }

  Future<void> checkSubscriptionStatus(int eventId) async {
    final getIsSubscribedUseCase = Get.find<IsSubscribed>();
    final status = await getIsSubscribedUseCase.call(eventId);
    _subscriptionStatus[eventId] = status;
  }

  bool isSubscribed(int eventId) {
    return _subscriptionStatus[eventId] ?? false;
  }

  Future<void> toggleSubscription(int eventId) async {
    final wasSubscribed = isSubscribed(eventId);
    // Optimistic update
    _subscriptionStatus[eventId] = !wasSubscribed;
    
    if (!wasSubscribed) {
      // Subscribing
      _attendees.value += 1;
      _spots.value -= 1;
    } else {
      // Unsubscribing
      _attendees.value -= 1;
      _spots.value += 1;
    }

    try {
      if (wasSubscribed) {
        await Get.find<UnsubscribeEventUseCase>().call(eventId);
      } else {
        await Get.find<SubscribeEventUseCase>().call(eventId);
      }
    } catch (e) {
      // Revert on error
      _subscriptionStatus[eventId] = wasSubscribed;
      if (!wasSubscribed) {
        _attendees.value -= 1;
        _spots.value += 1;
      } else {
        _attendees.value += 1;
        _spots.value -= 1;
      }
      rethrow;
    }
  }
}