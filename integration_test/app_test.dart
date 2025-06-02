import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:confhub/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Debería navegar a la pantalla de categorías, filtrar eventos, suscribirse a un evento y verificarlo en "Mis Eventos"',
      (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();

    await tester.pumpAndSettle();

    // Verifica que la pantalla inicial (Home Page) se cargue
    expect(find.text('Inicio'), findsOneWidget);

    // Encuentra el botón de navegación a Categorías en el Navigation Bar
    final categoriesButton =
        find.text('Categorias'); // Cambia esto según el texto o ícono del botón

    // Verifica que el botón esté presente
    expect(categoriesButton, findsOneWidget);

    // Haz clic en el botón de navegación a Categorías
    await tester.tap(categoriesButton);
    await tester.pumpAndSettle();

    // Verifica que la pantalla de categorías se cargue
    expect(find.text('Eventos por categoría'), findsOneWidget);

    // Encuentra los ChoiceChips de las categorías
    final choiceChip1 = find.text('Metodologías Ágiles');
    final choiceChip2 = find.text('Base de Datos');

    // Verifica que los ChoiceChips estén presentes
    expect(choiceChip1, findsOneWidget);
    expect(choiceChip2, findsOneWidget);

    // Haz clic en la categoría "Desarrollo Web"
    await tester.tap(choiceChip1);
    await tester.pumpAndSettle();

    log("fallo en la linea 48");

    // Verifica que los eventos de "Desarrollo Web" se muestren
    final eventname = 'Scrum y Agile en Equipos de Desarrollo';
    expect(find.text(eventname), findsOneWidget);
    expect(find.text('Evento 2'), findsNothing);

    log("fallo en la linea 55");
    // Encuentra el botón "Unirse Ahora" del evento
    final joinNowButton = find.text('Unirse Ahora');
    expect(joinNowButton, findsOneWidget);

    // Haz clic en el botón "Unirse Ahora"
    await tester.tap(joinNowButton);
    await tester.pumpAndSettle();

    log("fallo en la linea 64");
    // Verifica que la pantalla de detalles del evento se cargue
    expect(find.text('Descripción'), findsOneWidget);

    // Desplázate hacia abajo para encontrar el botón "Suscribir"
    final subscribeButton = find.text('Suscribir');
    await tester.drag(find.byType(SingleChildScrollView),
        const Offset(0, -1000)); // Ajusta el desplazamiento según sea necesario
    await tester.pumpAndSettle();

    // Verifica que el botón de "Suscribir" esté visible
    expect(subscribeButton, findsOneWidget);

    // Haz clic en el botón de "Suscribir"
    await tester.tap(subscribeButton);
    await tester.pumpAndSettle();

    expect(Text("90"), findsOneWidget);
    expect(Text("0"), findsOneWidget);

    // Retrocede a la pantalla anterior
    await tester.pageBack();
    await tester.pumpAndSettle();
    log("fallo en la linea 87");

    final choiceChip3 = find.text('Cloud');
    expect(choiceChip3, findsOneWidget);

    // Haz click en cloud
    await tester.tap(choiceChip3);
    await tester.pumpAndSettle();

    log("fallo en la linea 96");

    // Verifica que los eventos de cloud se muestren
    final eventname2 = 'AWS para Desarrolladores: Desplegando Aplicaciones';

    expect(find.text(eventname2), findsOneWidget);
    expect(find.text('Evento 3'), findsNothing);

    log("fallo en la linea 104");
    // Encuentra el botón "Unirse Ahora" del evento

    expect(joinNowButton, findsOneWidget);

    // Haz clic en el botón "Unirse Ahora"
    await tester.tap(joinNowButton);
    await tester.pumpAndSettle();

    log("fallo en la linea 113");
    // Verifica que la pantalla de detalles del evento se cargue
    expect(find.text('Descripción'), findsOneWidget);

    // Desplázate hacia abajo para encontrar el botón "Suscribir"
    await tester.drag(find.byType(SingleChildScrollView),
        const Offset(0, -1000)); // Ajusta el desplazamiento según sea necesario
    await tester.pumpAndSettle();

    // Verifica que el botón de "Suscribir" esté visible
    expect(subscribeButton, findsOneWidget);

    // Haz clic en el botón de "Suscribir"
    await tester.tap(subscribeButton);
    await tester.pumpAndSettle();

    // Encuentra el botón de navegación a "Mis Eventos" en el Navigation Bar
    final myEventsButton = find.text('Mis Eventos');

    // Verifica que el botón esté presente
    expect(myEventsButton, findsOneWidget);

    // Haz clic en el botón de navegación a "Mis Eventos"
    await tester.tap(myEventsButton);
    await tester.pumpAndSettle();

    // Verica que el evento esté en mis eventos
    expect(find.text(eventname2), findsOneWidget);

    // Haz clic en el evento en "Mis Eventos"
    await tester.tap(find.text(eventname));
    await tester.pumpAndSettle();

    // Verifica que la pantalla de detalles del evento se cargue nuevamente
    expect(find.text('Descripción'), findsOneWidget);

    // Desplázate hacia abajo para encontrar el botón "Desuscribir"
    final unsubscribeButton = find.text('Desuscribir');
    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -1000));
    await tester.pumpAndSettle();

    // Verifica que el botón de "Desuscribir" esté visible
    expect(unsubscribeButton, findsOneWidget);

    // Haz clic en el botón de "Desuscribir"
    await tester.tap(unsubscribeButton);
    await tester.pumpAndSettle();

    // Retrocede a la pantalla anterior
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Vuelve a la pantalla de inicio
    final homeButton = find.text('Inicio');
    await tester.tap(homeButton);
    await tester.pumpAndSettle();

    // Vuelve a "Mis Eventos"
    await tester.tap(myEventsButton);
    await tester.pumpAndSettle();

    // Verifica que el evento ya no esté en "Mis Eventos"
    expect(find.text(eventname), findsNothing);
  });
}
