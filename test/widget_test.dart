// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:confhub/core/utils/test_utils.dart';
import 'package:confhub/data/models/session_model.dart';
import 'package:confhub/domain/use_cases/get_all_events.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';
import 'package:confhub/ui/pages/event_detail_page.dart';
import 'package:confhub/ui/widgets/home/featured_webinars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:confhub/ui/widgets/timeline/event_card.dart';

import 'package:confhub/domain/entities/event.dart';

import 'mocks/get_all_events_usecase_mock.mocks.dart';

class MockEventPageController extends GetxService
    with Mock
    implements EventPageController {
  final _spots = "1".obs;
  final _attendees = "100".obs;

  final RxList<int> subscribedEvents = <int>[].obs; // Track subscribed events
  @override
  String get gspots => _spots.value;
  @override
  String get gattendees => _attendees.value;

  @override
  bool isSubscribed(int eventId) => subscribedEvents.contains(eventId);

  @override
  Future<void> initializeForEvent(int eventId) async {
  }

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
    AppEnvironment.isTest = true;
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


  tearDown(() {
    AppEnvironment.isTest = false;
  });

  testWidgets('FeaturedWebinars muestra los eventos del usecase',
      (WidgetTester tester) async {
    // Creamos el mock
    final mockUseCase = MockGetAllEventsUseCase();

    // Creamos una lista de eventos simulada
    final fakeEvents = [
      Event(
        eventid: 1,
        title: "FlutterConf 2025",
        date: "2025-05-01",
        time: "10:00 AM",
        category: "Desarrollo",
        attendees: 150,
        availableSpots: 50,
        speakerAvatar: "https://via.placeholder.com/150",
        speakerName: "Jean",
        location: "Virtual",
        description: "Una conferencia sobre Flutter",
        dateTime: DateTime.parse("2025-05-05T19:00:00Z"),
        tags: ["Flutter", "Mobile", "Dart"],
        sessionOrder: [SessionModel(
          name: 'Firter', 
          duration: 1,
        )],
      )
    ];

    // Le decimos al mock qué debe retornar cuando se llame
    when(mockUseCase.call()).thenAnswer((_) async => fakeEvents);

    // Lo inyectamos en GetX
    Get.put<GetAllEventsUseCase>(mockUseCase);

    // Renderizamos el widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              FeaturedWebinars(),
            ],
          ),
        ),
      ),
    );

    // Esperamos a que se resuelva el FutureBuilder
    await tester.pumpAndSettle();

    // Verificamos que el título del evento esté en pantalla
    expect(find.text("FlutterConf 2025"), findsOneWidget);
  });

   testWidgets('Tapping EventCard navigates to EventDetailPage', (WidgetTester tester) async {
    final testEvent = Event(
      eventid: 1245678,
      title: 'Test Event',
      description: 'Description',
      speakerAvatar: '',
      speakerName: 'Speaker',
      dateTime: DateTime.now(),
      date: '2025-04-08',
      location: 'Room A',
      time: '10:00 AM',
      attendees: 5,
      availableSpots: 10,
      category: 'Tech',
      tags: [],
      sessionOrder: [],
    );

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: EventCard(event: testEvent, isToday: true),
        ),
      ),
    );

    expect(find.text('Test Event'), findsOneWidget);
  
    await tester.tap(find.byType(EventCard));
    await tester.pumpAndSettle();

    // Verifying navigation
    expect(Get.currentRoute.contains('EventDetailPage'), true); 
  });
}
