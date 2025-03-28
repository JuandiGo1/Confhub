import 'package:confhub/ui/widgets/home/featured_webinars.dart';
import 'package:confhub/ui/widgets/home/header_section.dart';
import 'package:confhub/ui/widgets/home/upcoming_webinars.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 238, 232),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado
              HeaderSection(),
              SizedBox(height: 16),

              // Título
              Text(
                "Tenemos eventos para ti hoy!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Webinars Destacados
              FeaturedWebinars(),
              SizedBox(height: 16),

              // Próximos Webinars
              UpcomingWebinars(),
            ],
          ),
        ),
      ),
    );
  }
}
