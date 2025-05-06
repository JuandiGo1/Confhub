import 'package:confhub/core/db_helper.dart';
import '../models/event_model.dart';

class EventLocalDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<EventModel>> getAllEvents() async {
    final db = await _dbHelper.database;
    final result = await db.query('events');
    return result.map((json) => EventModel.fromJson(json)).toList();
  }

  Future<void> saveEvents(List<EventModel> events) async {
    final db = await _dbHelper.database;

    // Reemplazar los eventos existentes
    await db.transaction((txn) async {
      await txn.delete('events');
      for (var event in events) {
        // Convertir campos complejos a cadenas antes de guardar
        final eventData = event.toJson();
        eventData['sessionOrder'] = eventData['sessionOrder']?.toString();
        eventData['tags'] = eventData['tags'] != null
            ? (eventData['tags'] as List)
                .join(',') // Convertir lista a cadena separada por comas
            : null;

        await txn.insert('events', eventData);
      }
    });
  }

  Future<void> saveFeedback(
      int eventId,
      String title,
      String comment,
      double score,
      String datetime,
      int likes,
      int dislikes,
      String? answer) async {
    final db = await _dbHelper.database;

    // Insertar el feedback en la tabla
    await db.insert('feedbacks', {
      'eventid': eventId,
      'title': title,
      'comment': comment,
      'score': score,
      'datetime': datetime, // Fecha y hora en formato ISO 8601
      'likes': likes,
      'dislikes': dislikes,
      'answer': answer, // Puede ser null
      'isPublished': 0,
    });
  }

  Future<List<Map<String, dynamic>>> getUnpublishedFeedbacks() async {
    final db = await _dbHelper.database;
    return await db
        .query('feedbacks', where: 'isPublished = ?', whereArgs: [0]);
  }

  Future<void> markFeedbackAsPublished(int feedbackId) async {
    final db = await _dbHelper.database;
    await db.update(
      'feedbacks',
      {'isPublished': 1},
      where: 'feedbackid = ?',
      whereArgs: [feedbackId],
    );
  }
}
