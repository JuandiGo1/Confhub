
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
    final categoriesButton = find.text('Categorias'); // Cambia esto según el texto o ícono del botón

    // Verifica que el botón esté presente
    expect(categoriesButton, findsOneWidget);

    // Haz clic en el botón de navegación a Categorías
    await tester.tap(categoriesButton);
    await tester.pumpAndSettle();

    // Verifica que la pantalla de categorías se cargue
    expect(find.text('Eventos por categoría'), findsOneWidget);

    // Encuentra los ChoiceChips de las categorías
    final choiceChip1 = find.text('Desarrollo Web');
    final choiceChip2 = find.text('Sistemas Operativos');

    // Verifica que los ChoiceChips estén presentes
    expect(choiceChip1, findsOneWidget);
    expect(choiceChip2, findsOneWidget);

    // Haz clic en la categoría "Desarrollo Web"
    await tester.tap(choiceChip1);
    await tester.pumpAndSettle();

    // Verifica que los eventos de "Desarrollo Web" se muestren
    expect(find.text('Desarrollo Web con Spring Boot y Tailwind CSS'), findsOneWidget);
    expect(find.text('Evento 2'), findsNothing);

    // Encuentra el botón "Unirse Ahora" del evento
    final joinNowButton = find.text('Unirse Ahora');
    expect(joinNowButton, findsOneWidget);

    // Haz clic en el botón "Unirse Ahora"
    await tester.tap(joinNowButton);
    await tester.pumpAndSettle();

    // Verifica que la pantalla de detalles del evento se cargue
    expect(find.text('Descripción'), findsOneWidget);

    // Desplázate hacia abajo para encontrar el botón "Suscribir"
    final subscribeButton = find.text('Suscribir');
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -1000)); // Ajusta el desplazamiento según sea necesario
    await tester.pumpAndSettle();

    // Verifica que el botón de "Suscribir" esté visible
    expect(subscribeButton, findsOneWidget);

    // Haz clic en el botón de "Suscribir"
    await tester.tap(subscribeButton);
    await tester.pumpAndSettle();

    // Retrocede a la pantalla anterior
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Encuentra el botón de navegación a "Mis Eventos" en el Navigation Bar
    final myEventsButton = find.text('Mis Eventos');

    // Verifica que el botón esté presente
    expect(myEventsButton, findsOneWidget);

    // Haz clic en el botón de navegación a "Mis Eventos"
    await tester.tap(myEventsButton);
    await tester.pumpAndSettle();

    // Verifica que el evento "Desarrollo Web con Spring Boot y Tailwind CSS" esté en "Mis Eventos"
    expect(find.text('Desarrollo Web con Spring Boot y Tailwind CSS'), findsOneWidget);

    // Haz clic en el evento en "Mis Eventos"
    await tester.tap(find.text('Desarrollo Web con Spring Boot y Tailwind CSS'));
    await tester.pumpAndSettle();

    // Verifica que la pantalla de detalles del evento se cargue nuevamente
    expect(find.text('Descripción'), findsOneWidget);

    // Desplázate hacia abajo para encontrar el botón "Desuscribir"
    final unsubscribeButton = find.text('Desuscribir');
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -1000));
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
    expect(find.text('Desarrollo Web con Spring Boot y Tailwind CSS'), findsNothing);
  });
}