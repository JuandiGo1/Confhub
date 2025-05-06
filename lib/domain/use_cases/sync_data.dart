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

  SyncDataUseCase({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.feedbackRemoteDataSource,
    required this.feedbackLocalDataSource
  });

  Future<void> execute() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      await _syncData();
    }
  }

  Future<void> _syncData() async {
    // 1. Enviar feedbacks no publicados
    final unpublishedFeedbacks = await localDataSource.getUnpublishedFeedbacks();
    for (var feedback in unpublishedFeedbacks) {
      await feedbackRemoteDataSource.sendFeedback(feedback); // Cambiado para usar EventRemoteDataSource
      await localDataSource.markFeedbackAsPublished(feedback['id']);
    }

    // 2. Verificar si la apiVersion cambió
    final remoteApiVersion = await remoteDataSource.getApiVersion(); // Usar EventRemoteDataSource
    final localApiVersion = await localDataSource.getApiVersion(); // Usar EventLocalDataSource

    if (remoteApiVersion != localApiVersion) {
      // Si las versiones son diferentes, actualiza los datos locales
      final events = await remoteDataSource.getAllEvents(); // Obtener eventos desde el remoto
      await localDataSource.saveEvents(events); // Guardar eventos en la base de datos local
      await localDataSource.saveApiVersion(remoteApiVersion); // Actualizar la versión local
    }
  }
}