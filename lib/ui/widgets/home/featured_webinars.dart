import 'package:confhub/core/colors.dart';
import 'package:confhub/ui/widgets/home/webinar_card.dart';
import 'package:flutter/material.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/use_cases/get_all_events.dart';
import 'package:get/get.dart';

class FeaturedWebinars extends StatelessWidget {
  const FeaturedWebinars({super.key});

  @override
  Widget build(BuildContext context) {
    final getAllEventsUseCase = Get.find<GetAllEventsUseCase>();

    // Define una lista de colores para los eventos
    final List<Color> colorsCard = [
      AppColors.primary,
      AppColors.cardSecond,
      AppColors.cardThird,
    ];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: 280, // Altura fija para el carrusel
          child: FutureBuilder<List<Event>>(
            future: getAllEventsUseCase.call(), // Llamamos al caso de uso
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Cargando...
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error al cargar eventos'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No hay eventos disponibles'));
              }
            
              final events = snapshot.data!;
            
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  // Selecciona el color basado en el índice
                  final color = colorsCard[index % colorsCard.length];
                      
                  return Padding(
                    padding: EdgeInsets.only( right: index == events.length - 1 ? 16 : 0),
                    child: Webinarcard(
                      title: events[index].title,
                      date: events[index].date,
                      category: events[index].category,
                      color: color,
                      attendees: events[index].attendees,
                      speakerAvatar: events[index].speakerAvatar,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
