import 'dart:developer';

import 'package:confhub/core/db_helper.dart';
import 'package:confhub/ui/pages/content_page.dart';
import 'package:flutter/material.dart';
import 'package:confhub/domain/use_cases/sync_data.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/data/sources/event_remote_data_source.dart';
import 'package:confhub/data/sources/feedback_local_data_source.dart';
import 'package:confhub/data/sources/feedback_remote_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SyncDataUseCase syncDataUseCase;

  @override
  void initState() {
    super.initState();

    // Inicializar el caso de uso
    syncDataUseCase = SyncDataUseCase(
      localDataSource: EventLocalDataSource(),
      remoteDataSource: EventRemoteDataSource(localDataSource: EventLocalDataSource()),
      feedbackRemoteDataSource: FeedbackRemoteDataSource(),
      feedbackLocalDataSource: FeedbackLocalDataSource(),
    );

    // Sincronizar datos y navegar a la HomePage
    _syncAndNavigate();
  }

  Future<void> _syncAndNavigate() async {
    try {
       // Inicializar la base de datos
      final dbHelper = DatabaseHelper();
      await dbHelper.database;
      
      await syncDataUseCase.execute();
      log("Sincronización completada");
    } catch (e) {
      log("Error durante la sincronización: $e");
    } finally {
      // Verificar si el widget sigue montado antes de usar el contexto
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ContentPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/confhub.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            // Loader
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
