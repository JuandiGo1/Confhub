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
    EventPageController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: colorName,
      ),
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(20),
                  height: 750,
                  decoration: BoxDecoration(color: colorName),
                  child: Row(children: [
                    Expanded(
                        child: Center(
                            child: Column(children: [
                      Text(
                        eventTitle,
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            eventLocation,
                            style: TextStyle(
                                fontSize: 15, color: AppColors.textPrimary),
                          ),
                        ],
                      )
                    ]))),
                  ]))),
          Positioned.fill(
              top: 130,
              child: Expanded(
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
                              fontSize: 15, color: AppColors.background),
                        ),
                        SizedBox(
                          width: 220,
                        ),
                        Text(eventTime,
                            style: TextStyle(
                                fontSize: 15, color: AppColors.background))
                      ]),
                    )
                  ],
                ),
              ))),
          Positioned.fill(
              top: 175,
              child: Container(
                padding: EdgeInsets.only(top: 20),
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
                            )),
                        Text(eventDescription,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            )),
                        Container(
                            padding: EdgeInsets.only(top: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text('Asistentes',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.primary)),
                                    Obx(() => Text("${controller.gattendees}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.textPrimary)))
                                  ],
                                ),
                                SizedBox(
                                  width: 150,
                                ),
                                Column(
                                  children: [
                                    Text('Disponibles',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.primary)),
                                    Obx(() => Text("${controller.gspots}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.textPrimary)))
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
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(eventSpeakerName,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.primary,
                                      )),
                                ])),
                        Container(
                            padding: EdgeInsets.only(top: 45),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.toggleSubscription(eventId);
                                      },
                                      child: Obx(() => Icon(
                                        controller.isSubscribed(eventId) 
                                          ? Icons.favorite 
                                          : Icons.favorite_border,
                                        color: controller.isSubscribed(eventId) ? Colors.red : null,
                                      )),
                                    ),
                                    SizedBox(width: 8),
                                    Obx(() => Text(
                                      controller.isSubscribed(eventId) ? "Desuscribir" : "Suscribir",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.textPrimary,
                                      ),))
                                ]))
                      ],
                    )),
              ))
        ],
      ),
    );
  }
}
