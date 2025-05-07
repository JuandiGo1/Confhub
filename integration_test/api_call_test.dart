import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:confhub/data/sources/event_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'mocks/event_local_mock.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late EventRemoteDataSource remoteDataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource =
        EventRemoteDataSource(localDataSource: MockLocalDataSource());
  });

  test('Debería obtener eventos desde la API correctamente', () async {
    // URL de la API
    final url = Uri.parse("http://localhost:3000/api/events");

    // Respuesta simulada de la API
    final response = http.Response(
      json.encode([
        {
          "eventid": 1,
          "title": "Evento 1",
          "category": "Desarrollo Web",
          "location": "Bogotá, Colombia",
          "dateTime": "2025-05-03T10:00:00.000Z",
          "attendees": 120,
          "availableSpots": 150,
          "description":
              "Aprende a construir aplicaciones web modernas con Spring Boot en el backend y Tailwind CSS en el frontend.",
          "speakerName": "Carlos Ríos",
          "speakerAvatar":
              "https://avatar.iran.liara.run/username?username=Carlos+Rios",
          "sessionOrder": [
            {"name": "Introducción a Spring Boot", "duration": 30},
            {
              "name": "Integración de Tailwind CSS en proyectos Spring Boot",
              "duration": 40
            },
            {"name": "Optimización y despliegue", "duration": 35}
          ],
          "tags": ["Spring Boot", "Tailwind CSS", "Desarrollo Web"],
          "avgScore": 0,
          "numberReviews": 0,
          "status": "Por empezar"
        },
        {
          "eventid": 2,
          "title": "Evento 2",
          "category": "Sistemas Operativos",
          "location": "Medellín, Colombia",
          "dateTime": "2025-05-03T14:00:00.000Z",
          "attendees": 80,
          "availableSpots": 100,
          "description":
              "Domina la administración de sistemas Linux y aprende técnicas avanzadas para optimizar servidores.",
          "speakerName": "Andrea Gómez",
          "speakerAvatar":
              "https://avatar.iran.liara.run/username?username=Andrea+Gomez",
          "sessionOrder": [
            {"name": "Gestión de usuarios y permisos", "duration": 25},
            {"name": "Automatización con Bash y cron jobs", "duration": 30},
            {"name": "Seguridad y monitoreo de servidores", "duration": 40}
          ],
          "tags": ["Linux", "Administración de sistemas", "Seguridad"],
          "avgScore": 0,
          "numberReviews": 0,
          "status": "Por empezar"
        }
      ]),
      200,
    );

    // Configurar el mock para devolver la respuesta simulada
    when(mockHttpClient.get(url)).thenAnswer((_) async => response);

    // Llamar al método que se está probando
    final events = await remoteDataSource.getAllEvents();

    // Verificar que los eventos se obtuvieron correctamente
    expect(events.length, 2);
    expect(events[0].eventid, 1);
    expect(events[0].title, "Evento 1");
    expect(events[1].eventid, 2);
    expect(events[1].title, "Evento 2");

    // Verificar que se realizó la solicitud HTTP
    verify(mockHttpClient.get(url)).called(1);
  });
}
