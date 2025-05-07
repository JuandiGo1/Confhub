import 'package:confhub/dependencies.dart';
import 'package:confhub/ui/pages/event_lines.dart';
import 'package:confhub/ui/pages/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  initDependencies(); // Carga todas las dependencias
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeDateFormatting('es', null); // Inicializa para el idioma español

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Confhub Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.bitterTextTheme(),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 203, 236, 229)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/enventLines', page: () => EventLines())
      ],
    );

  }
}
