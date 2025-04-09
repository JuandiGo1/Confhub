import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/use_cases/get_all_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'upcoming_card.dart';

class UpcomingWebinars extends StatelessWidget {
  const UpcomingWebinars({super.key});

  @override
  Widget build(BuildContext context) {
    final getAllEventsUseCase = Get.find<GetAllEventsUseCase>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(230, 243, 243, 243),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        //Interior Proximos wbe
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Próximos Webinars",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.title,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Acción para el botón "Ver más"
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Ver más",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(
                            width: 5), // Espaciado entre el texto y el ícono
                        Icon(Icons.east, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //TARJETAS DE EVENTOS
            Expanded(
              child: SizedBox(
                // Altura fija
                child: FutureBuilder<List<Event>>(
                  future: getAllEventsUseCase.call(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error al cargar eventos'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No hay eventos disponibles'));
                    }

                    final events = snapshot.data!;
                    //MAPEANDO EVENTOS
                    return ListView.builder(
                      scrollDirection: Axis.horizontal, // Scroll horizontal
                      physics: BouncingScrollPhysics(),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return SizedBox(
                          width: 370, // Define un ancho para los elementos
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: UpcomingCard(
                            title: event.title,
                            date: event.date,
                            category: event.category,
                            time: event.time,
                            speakerAvatar: event.speakerAvatar,
                            event: event,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
