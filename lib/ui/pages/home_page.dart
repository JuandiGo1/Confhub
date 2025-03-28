
import 'package:confhub/core/colors.dart';

import 'package:confhub/ui/widgets/home/featured_webinars.dart';
import 'package:confhub/ui/widgets/home/header_section.dart';
import 'package:confhub/ui/widgets/home/upcoming_webinars.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:  AppColors.background ,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            HeaderSection(),
            SizedBox(height: 5),
        
            // Título
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Tenemos eventos para ti hoy!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
        
            // Webinars Destacados
            FeaturedWebinars(),
            SizedBox(height: 16),
        
            // Próximos Webinars
            UpcomingWebinars(),
          ],
      
          ),
        ),
      );
  }
}
