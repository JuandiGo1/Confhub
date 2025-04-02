import 'dart:developer';

import 'package:confhub/domain/use_cases/subscribe_an_event.dart';
import 'package:get/get.dart';


class EventPageController extends GetxController {
  final int attendees;
  final int spots;

  EventPageController({required this.attendees, required this.spots}) {
    updateNumbers();
  }
  var _spots = "0".obs;
  var _attendees = "0".obs;
  var _iconChange = false.obs;
  String get gspots => _spots.value;
  String get gattendees => _attendees.value;
  bool get iconChange => _iconChange.value;
  void updateNumbers() {
    _spots.value = "$spots";
    _attendees.value = "$attendees";
  }

  Future<void> countSubPlus(int eventid) async {
    if (int.parse(_spots.value) >= 1 && !iconChange) {
      final op = int.parse(_spots.value) - 1;
      final op2 = int.parse(_attendees.value) + 1;
      _spots.value = "$op";
      _attendees.value = "$op2";

      _iconChange.value = true;
    }

    await (int eventid) async {
      final subscribeAnEventUseCase = Get.find<SubscribeAnEventUseCase>();
      return await subscribeAnEventUseCase.call(eventid);
    }(eventid);
  }

  Future<void> countSubSub(int eventid) async {
    if (iconChange) {
      final op = int.parse(_spots.value) + 1;
      final op2 = int.parse(_attendees.value) - 1;
      _spots.value = "$op";
      _attendees.value = "$op2";

      _iconChange.value = false;
    }

    await (int eventid) async {
      final subscribeAnEventUseCase = Get.find<SubscribeAnEventUseCase>();
      final work = await subscribeAnEventUseCase.call(eventid);
      log("$work");
      return work;
    }(eventid);
  }
}
