import 'package:confhub/core/colors.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';
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
      required this.eventSpots});

  final Color colorName = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    EventPageController controller = Get.find<EventPageController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeForEvent(eventId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: colorName,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              height: 750,
              decoration: BoxDecoration(color: colorName),
              child: Row(children: [
                Expanded(
                    child: Center(
                        child: Column(children: [
                  Text(
                    eventTitle,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        eventLocation,
                        style: TextStyle(
                            fontSize: 15,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ]))),
              ])),
          Positioned.fill(
              top: 130,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(children: [
                        Text(
                          eventDate,
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColors.background,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 220,
                        ),
                        Text(eventTime,
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.background,
                                fontWeight: FontWeight.w700))
                      ]),
                    )
                  ],
                ),
              )),
          Positioned.fill(
              top: 175,
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 30),
                decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Descripción',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700)),
                        Text(eventDescription,
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700)),
                        Container(
                            padding: EdgeInsets.only(top: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Asistentes',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700)),
                                    Obx(() => Text(controller.gattendees,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.w700)))
                                  ],
                                ),
                                SizedBox(width: 30),
                                Column(
                                  children: [
                                    Text('Disponibles',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700)),
                                    Obx(() => Text(controller.gspots,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.w700)))
                                  ],
                                )
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(top: 70),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.campaign),
                                  Text("Orador",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(eventSpeakerName,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700)),
                                ])),
                        Container(
                          padding: EdgeInsets.only(top: 45),
                          child: Obx(() {
                            final isSubscribed =
                                controller.isSubscribed(eventId);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                               GestureDetector(
                                  onTap: () {
                                    final spots = int.tryParse(controller.gspots) ?? 0;
                                    final isSubscribed = controller.isSubscribed(eventId);

                                    if (isSubscribed || spots > 0) {
                                      controller.toggleSubscription(eventId);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('No hay cupos disponibles para este evento.'),
                                          backgroundColor: Colors.redAccent,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },

                                  child: Icon(
                                    isSubscribed ? Icons.favorite : Icons.favorite_border,
                                    color: isSubscribed
                                        ? Colors.red
                                        : (int.tryParse(controller.gspots) ?? 0) == 0
                                            ? Colors.grey
                                            : null,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  isSubscribed ? "Desuscribir" : "Suscribir",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.textPrimary,
                                  )
                                ),
                            ]);
                          }))
                      ],
                    )),
              ))
        ],
      )),
    );
  }
}
