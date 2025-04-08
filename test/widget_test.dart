// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:confhub/ui/controllers/event_page_controller.dart';
import 'package:confhub/ui/pages/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';


class MockEventPageController extends GetxService
    with Mock
    implements EventPageController {
  var _spots = "1".obs;
  var _attendees = "100".obs;
  @override
  final RxList<int> subscribedEvents = <int>[].obs; // Track subscribed events
  @override
  String get gspots => _spots.value;
  @override
  String get gattendees => _attendees.value;

  @override
  bool isSubscribed(int eventId) => subscribedEvents.contains(eventId);

  @override
  Future<void> toggleSubscription(int eventId) async {
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
  }
}

void main() {
  setUp(() {
    final controller = MockEventPageController();
    Get.put<EventPageController>(controller);
  });
  testWidgets('test the subscription buttom', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GetMaterialApp(
        home: EventDetailPage(
            eventId: 1245678,
            eventTitle: "Introducción a Node.js y Express",
            eventCategory: "Backend",
            eventDate: "Lun, 14",
            eventTime: "14:00",
            eventAttendees: 100,
            eventDescription:
                "Descubre el mundo del desarrollo backend con Node.js y Express. Aprensderás los conceptos básicos de Node.js, cómo configurar un servidor con Express y gestionar rutas y middlewares. Ideal para quienes quieren iniciar en el desarrollo de APIs modernas.",
            eventSpeakerName: "Carlos Rios",
            eventSpeakerAvatar:
                "https://avatar.iran.liara.run/username?username=Carlos+Rios",
            eventLocation: "Barranquilla, Colombia",
            eventSpots: 1)));

    // Verify that attendees starts at initial values.
    expect(find.text('100'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.ensureVisible(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    // Tap the 'fav' icon and subscribed.
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    // Verify that values have changed.
    expect(find.text('101'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Tap the 'fav' icon and unsubsdribed.
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();

    // Verify that values are the same as the initials.

    expect(find.text('100'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });
}
