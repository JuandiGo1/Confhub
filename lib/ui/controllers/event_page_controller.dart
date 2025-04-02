import 'dart:developer';
import 'package:confhub/domain/use_cases/subscribe_an_event.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventPageController extends GetxController {
  final int attendees;
  final int spots;
  final RxList<int> subscribedEvents = <int>[].obs; // Track subscribed events

  EventPageController({required this.attendees, required this.spots}) {
    updateNumbers();
  }
  
  var _spots = "0".obs;
  var _attendees = "0".obs;
  String get gspots => _spots.value;
  String get gattendees => _attendees.value;
  
  // Simplified icon state - now derived from subscription status
  bool isSubscribed(int eventId) => subscribedEvents.contains(eventId);

  void updateNumbers() {
    _spots.value = "$spots";
    _attendees.value = "$attendees";
  }

  Future<void> toggleSubscription(int eventId) async {
    final subscribeAnEventUseCase = Get.find<SubscribeAnEventUseCase>();
    
    if (isSubscribed(eventId)) {
      // Unsubscribe logic
      final op = int.parse(_spots.value) + 1;
      final op2 = int.parse(_attendees.value) - 1;
      _spots.value = "$op";
      _attendees.value = "$op2";
      subscribedEvents.remove(eventId);
    } else {
      // Subscribe logic
      if (int.parse(_spots.value) >= 1) {
        final op = int.parse(_spots.value) - 1;
        final op2 = int.parse(_attendees.value) + 1;
        _spots.value = "$op";
        _attendees.value = "$op2";
        subscribedEvents.add(eventId);
      }
    }
    
    try {
      final result = await subscribeAnEventUseCase.call(eventId);
      log("Subscription result: $result");
    } catch (e) {
      log("Error in subscription: $e");
      // Revert changes if the operation failed
      if (isSubscribed(eventId)) {
        final op = int.parse(_spots.value) + 1;
        final op2 = int.parse(_attendees.value) - 1;
        _spots.value = "$op";
        _attendees.value = "$op2";
        subscribedEvents.remove(eventId);
      } else {
        final op = int.parse(_spots.value) - 1;
        final op2 = int.parse(_attendees.value) + 1;
        _spots.value = "$op";
        _attendees.value = "$op2";
        subscribedEvents.add(eventId);
      }
    }
  }
}