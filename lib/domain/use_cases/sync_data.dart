import 'dart:developer';

import 'package:confhub/data/sources/feedback_local_data_source.dart';
import 'package:confhub/data/sources/feedback_remote_data_source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/data/sources/event_remote_data_source.dart';

class SyncDataUseCase {
  final EventLocalDataSource localDataSource;
  final EventRemoteDataSource remoteDataSource;
  final FeedbackRemoteDataSource feedbackRemoteDataSource;
  final FeedbackLocalDataSource feedbackLocalDataSource;

  SyncDataUseCase(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.feedbackRemoteDataSource,
      required this.feedbackLocalDataSource});

  Future<void> execute() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      await _syncData();
    }
  }

  Future<void> _syncData() async {
    // 1. Enviar feedbacks no publicados
    final unpublishedFeedbacks =
        await localDataSource.getUnpublishedFeedbacks();
    for (var feedback in unpublishedFeedbacks) {
      await feedbackRemoteDataSource.sendFeedback(feedback);
      await localDataSource.markFeedbackAsPublished(feedback['id']);
    }

    // 2. Verificar si la apiVersion cambió
    final remoteApiVersion = await remoteDataSource.getApiVersion();

    final localApiVersion = await localDataSource.getApiVersion();

    log("APIVERSION SIN CAMBIOS entrante: $remoteApiVersion y actual: $localApiVersion");
    if (remoteApiVersion != localApiVersion) {
      // Si las versiones son diferentes, actualiza los datos locales
      await remoteDataSource
          .getAllEvents(); // Esta misma fun guardar eventos en la base de datos local
      await localDataSource
          .saveApiVersion(remoteApiVersion);
      
      log("APIVERSION ACTUALIZADA entrante: $remoteApiVersion y actual: $localApiVersion"); // Actualizar la versión local
    }

    // 3. Sincronizar eventos suscritos
    await _syncSubscribedEvents();
  }

  Future<void> _syncSubscribedEvents() async {
    try {
      // Obtener eventos suscritos localmente
      final localSubscribedEventIds =
          await localDataSource.getSubscribedEventIds();

      for (var eventId in localSubscribedEventIds) {
        // Intentar suscribir cada evento en el servidor
        final success = await remoteDataSource.subscribeAnEvent(eventId);
        if (success) {
          log("Evento sincronizado con el servidor: $eventId");
        } else {
          log("El evento ya estaba suscrito en el servidor: $eventId");
        }
      }
    } catch (e) {
      log("Error al sincronizar eventos suscritos: $e");
    }
  }
}
