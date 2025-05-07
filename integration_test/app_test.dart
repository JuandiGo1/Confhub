import 'package:confhub/core/utils/date_formatter.dart';
import 'package:confhub/data/repositories/event_repository_impl.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/data/sources/event_remote_data_source.dart';
import 'package:confhub/domain/repositories/event_repository.dart';
import 'package:confhub/main.dart';
import 'package:confhub/ui/widgets/enventLines/card_event.dart';
import 'package:confhub/ui/widgets/home/webinar_card.dart';
import 'package:confhub/ui/widgets/timeline/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test the subscription buttom', (WidgetTester tester) async {
    Get.put<EventLocalDataSource>(
        EventLocalDataSource()); // Fuente de datos local
    Get.put<EventRemoteDataSource>(
        EventRemoteDataSource()); // fuente de datos remota
    Get.put<EventRepository>(EventRepositoryImpl(Get.find()));

    await tester.pumpWidget(const MyApp());

    await tester.pump();

    // navigate to one upcoming event

    await tester.tap(find.byWidgetPredicate(
      (widget) =>
          widget is Webinarcard &&
          widget.title == "Construccion de APIs REST con FastAPI",
    ));

    // Verify that attendees starts at initial values.
    expect(find.text('80'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.ensureVisible(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    // Tap the 'fav' icon and subscribed.
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    // Verify that values have changed.
    expect(find.text('81'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Tap the 'fav' icon and unsubscribed.
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();

    // Verify that values are the same as the initials.
    expect(find.text('100'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('test the subscription buttom when the available spots are 0',
      (WidgetTester tester) async {
    Get.put<EventLocalDataSource>(
        EventLocalDataSource()); // Fuente de datos local
    Get.put<EventRemoteDataSource>(
        EventRemoteDataSource()); // fuente de datos remota
    Get.put<EventRepository>(EventRepositoryImpl(Get.find()));

    await tester.pumpWidget(const MyApp());

    await tester.pump();

    // navigate to one upcoming event with 0 spots

    await tester.tap(find.byWidgetPredicate(
      (widget) =>
          widget is Webinarcard &&
          widget.title == "Flutter desde Cero: Construyendo Apps Móviles",
    ));

    // Verify that attendees starts at initial values.
    expect(find.text('85'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    await tester.ensureVisible(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    // try to subscribe when there are not spots
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    //verify that the snackbar shows out
    expect(
        find.byWidget(SnackBar(
          content: const Text('No hay cupos disponibles para este evento.'),
          backgroundColor: Colors.redAccent,
        )),
        findsOneWidget);

    // verify that values haven't changed
    expect(find.text('85'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });

// feedback part

// navigation
  testWidgets('test the navigation througth the app + update of an subscribed event on my events',
      (WidgetTester tester) async {
    Get.put<EventLocalDataSource>(
        EventLocalDataSource()); // Fuente de datos local
    Get.put<EventRemoteDataSource>(
        EventRemoteDataSource()); // fuente de datos remota
    Get.put<EventRepository>(EventRepositoryImpl(Get.find()));

    await tester.pumpWidget(const MyApp());

    await tester.pump();

    // navigate to one event from today if they exist

    await tester.tap(find.byWidgetPredicate(
      (widget) =>
          widget is Webinarcard &&
          widget.date ==
              formatDate(DateTime(
                2025,
                5,
                5,
                0,
                0,
                0,
                0,
                0,
              )),
    ));

    // Verify that show the core data of the event
    expect(find.text('Construcción de APIs REST con FastAPI'), findsOneWidget);
    expect(find.text('Bogota, Colombia'), findsOneWidget);
    expect(
        find.text(
            'Aprende a desarrollar APIs REST modernas y eficientes con FastAPI. Exploraremos desde la creación de una API básica hasta la autenticación y seguridad en el backend.'),
        findsOneWidget);
    expect(find.text('Daniel Paredes'), findsOneWidget);

    // Verify that attendees starts at initial values.
    expect(find.text('80'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    // go back
    await tester.pageBack();
    await tester.pumpAndSettle();

    //go to my categories

    await tester.tap(find.byIcon(Icons.event));

    // verify the presence of some categories

    expect(find.text('Backend'), findsOneWidget);
    expect(find.text('Frontend'), findsOneWidget);
    expect(find.text('Mobile'), findsOneWidget);

    expect(find.byType(CardEvent), findsExactly(18));

    await tester.tap(find.byWidgetPredicate(
      (widget) =>
          widget is Webinarcard &&
          widget.date == 'Construcción de APIs REST con FastAPI',
    ));

    // Verify that show the core data of the event
    expect(find.text('Construcción de APIs REST con FastAPI'), findsOneWidget);
    expect(find.text('Bogota, Colombia'), findsOneWidget);
    expect(
        find.text(
            'Aprende a desarrollar APIs REST modernas y eficientes con FastAPI. Exploraremos desde la creación de una API básica hasta la autenticación y seguridad en el backend.'),
        findsOneWidget);
    expect(find.text('Daniel Paredes'), findsOneWidget);

    // Verify that attendees starts at initial values.
    expect(find.text('80'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.ensureVisible(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    // Tap the 'fav' icon and subscribed.
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    // Verify that values have changed.
    expect(find.text('81'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // go back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // go to my events

    await tester.tap(find.byIcon(Icons.favorite_border));

    // verify the presence of events

    expect(find.text('No hay eventos suscritos'), findsNothing);
    expect(find.byType(EventCard), findsOne);

    // go to event detail page
    await tester.tap(find.byType(EventCard));
    await tester.ensureVisible(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    // Verify that values haven't changed.
    expect(find.text('81'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Tap the 'fav' icon and unsubscribed.
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    // Verify that values have changed.
    expect(find.text('80'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    // go back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // verify the no presence of events
    expect(find.text('No hay eventos suscritos'), findsOneWidget);

  });
}
