import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/entities/session.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';
import 'package:confhub/ui/controllers/feedback_page_controller.dart';
import 'package:confhub/ui/pages/feedback_page.dart';
import 'package:confhub/ui/widgets/eventDetails/session_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailPage extends StatelessWidget {
  final int eventId;
  final String eventTitle;
  final String eventCategory;
  final String eventDate;
  final String eventTime;
  final int eventAttendees;
  final String eventDescription;
  final String eventSpeakerName;
  final String eventSpeakerAvatar;
  final String eventLocation;
  final int eventSpots;
  final double eventavgScore;
  final String eventstatus;
  final List<Session> eventSessionOrder;
  final Color colorName;
  final int numberReviews;

  const EventDetailPage(
      {super.key,
      required this.eventId,
      required this.eventTitle,
      required this.eventCategory,
      required this.eventDate,
      required this.eventTime,
      required this.eventAttendees,
      required this.eventDescription,
      required this.eventSpeakerName,
      required this.eventSpeakerAvatar,
      required this.eventLocation,
      required this.eventSpots,
      required this.eventavgScore,
      required this.eventstatus,
      required this.eventSessionOrder,
      required this.numberReviews,
      this.colorName = const Color.fromARGB(255, 53, 80, 126)});

  @override
  Widget build(BuildContext context) {
    EventPageController controller = Get.find<EventPageController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeForEvent(eventId);
    });
    final starSize = 10.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(eventTitle),
        backgroundColor: colorName,
      ),
      backgroundColor: const Color.fromARGB(230, 243, 243, 243),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado del evento
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: colorName),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    eventTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    eventLocation,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        eventDate,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        eventTime,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Descripción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 20,
                      color: colorName,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    eventDescription,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Orden de la Conferencia
                  Text(
                    "Orden de la Conferencia",
                    style: TextStyle(
                      fontSize: 20,
                      color: colorName,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 15),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: eventSessionOrder.length,
                    itemBuilder: (context, index) {
                      final session = eventSessionOrder[index];
                      return SessionCard(
                        index: index,
                        session: session,
                        color: colorName,
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // Asistentes y Disponibles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Asistentes',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorName,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Obx(() => Text(
                                controller.gattendees,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Disponibles',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorName,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Obx(() => Text(
                                controller.gspots,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Orador
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.campaign, color: colorName),
                      SizedBox(width: 10),
                      Text(
                        "Orador:",
                        style: TextStyle(
                          fontSize: 15,
                          color: colorName,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          eventSpeakerName,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Botón de calificación
                  if (eventstatus == "Finalizado")
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => FeedbackPage(
                                eventid: eventId,
                                principal: colorName,
                              ));
                          Get.put<FeedbackPageController>(
                              FeedbackPageController());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorName,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "Calificar Evento",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Botón de suscripción
                  if (eventstatus == "Por empezar")
                    Obx(() {
                      final isSubscribed = controller.isSubscribed(eventId);
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            final spots = int.tryParse(controller.gspots) ?? 0;
                            if (isSubscribed || spots > 0) {
                              controller.toggleSubscription(eventId);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'No hay cupos disponibles para este evento.'),
                                  backgroundColor: Colors.redAccent,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isSubscribed
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isSubscribed
                                    ? Colors.red
                                    : (int.tryParse(controller.gspots) ?? 0) == 0
                                        ? Colors.grey
                                        : colorName,
                              ),
                              SizedBox(width: 8),
                              Text(
                                isSubscribed ? "Desuscribir" : "Suscribir",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: colorName,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
