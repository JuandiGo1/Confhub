import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/entities/session.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';
import 'package:confhub/ui/controllers/feedback_page_controller.dart';
import 'package:confhub/ui/pages/feedback_page.dart';
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
      this.colorName = AppColors.primary});

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
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(20),
                  height: 900,
                  decoration: BoxDecoration(color: colorName),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Text(
                                eventTitle,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                eventLocation,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700),
                              )
                            ])),
                      ]))),
          Positioned.fill(
              top: 130,
              child: Container(
                height: 700,
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
                height: 400,
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
                                color: colorName,
                                fontWeight: FontWeight.w700)),
                        Text(eventDescription,
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Orden de la Conferencia",
                            style: TextStyle(
                                fontSize: 20,
                                color: colorName,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: 200,
                            decoration: BoxDecoration(
                                color: AppColors.textPrimary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Center(
                                child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxHeight: 180, maxWidth: 600),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection:
                                    Axis.horizontal, // Scroll horizontal
                                physics: BouncingScrollPhysics(),
                                itemCount: eventSessionOrder.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: 20,
                                        left: 20,
                                        top: 10,
                                        bottom: 10),
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        color: colorName),
                                    width: 100,
                                    height: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("${index + 1}",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(eventSessionOrder[index].name,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700)),
                                        Text(
                                          "${eventSessionOrder[index].duration} min",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text('Asistentes',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: colorName,
                                            fontWeight: FontWeight.w700)),
                                    Obx(() => Text(controller.gattendees,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.w700)))
                                  ],
                                ),
                                SizedBox(width: 120),
                                Column(
                                  children: [
                                    Text('Disponibles',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: colorName,
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
                                          color: colorName,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(eventSpeakerName,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w700)),
                                ])),
                        eventstatus == "Finalizado"
                            ? SizedBox(
                                height: 40,
                              )
                            : Text(""),
                        eventstatus == "Finalizado"
                            ? Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => FeedbackPage(
                                            eventid: eventId,
                                            principal: colorName,
                                          ));
                                      Get.put<FeedbackPageController>(
                                          FeedbackPageController());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      width: 350,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Calificación promedio:',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: colorName,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          eventavgScore > 0
                                              ? eventavgScore <= 0.5
                                                  ? Icon(
                                                      Icons.star_half,
                                                      color: colorName,
                                                    )
                                                  : Icon(
                                                      Icons.star,
                                                      color: colorName,
                                                    )
                                              : Icon(
                                                  Icons.star_border,
                                                  color: colorName,
                                                ),
                                          eventavgScore > 1
                                              ? eventavgScore <= 1.5
                                                  ? Icon(
                                                      Icons.star_half,
                                                      color: colorName,
                                                    )
                                                  : Icon(
                                                      Icons.star,
                                                      color: colorName,
                                                    )
                                              : Icon(
                                                  Icons.star_border,
                                                  color: colorName,
                                                ),
                                          eventavgScore > 2
                                              ? eventavgScore <= 2.5
                                                  ? Icon(
                                                      Icons.star_half,
                                                      color: colorName,
                                                    )
                                                  : Icon(
                                                      Icons.star,
                                                      color: colorName,
                                                    )
                                              : Icon(Icons.star_border,
                                                  color: colorName),
                                          eventavgScore > 3
                                              ? eventavgScore <= 3.5
                                                  ? Icon(Icons.star_half,
                                                      color: colorName)
                                                  : Icon(Icons.star,
                                                      color: colorName)
                                              : Icon(Icons.star_border,
                                                  color: colorName),
                                          eventavgScore > 4
                                              ? eventavgScore <= 4.5
                                                  ? Icon(
                                                      Icons.star_half,
                                                      color: colorName,
                                                    )
                                                  : Icon(
                                                      Icons.star,
                                                      color: colorName,
                                                    )
                                              : Icon(Icons.star_border,
                                                  color: colorName),
                                          SizedBox(width: 10),
                                          Text(
                                            'Criticas',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: colorName,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(width: 7),
                                          Icon(Icons.reviews,
                                              color: AppColors.textPrimary)
                                        ],
                                      ),
                                    )),
                              )
                            : Text(""),
                        eventstatus == "Por empezar"
                            ? Container(
                                padding: EdgeInsets.only(top: 25),
                                child: Obx(() {
                                  final isSubscribed =
                                      controller.isSubscribed(eventId);
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            final spots = int.tryParse(
                                                    controller.gspots) ??
                                                0;
                                            final isSubscribed = controller
                                                .isSubscribed(eventId);

                                            if (isSubscribed || spots > 0) {
                                              controller
                                                  .toggleSubscription(eventId);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: const Text(
                                                      'No hay cupos disponibles para este evento.'),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  duration: const Duration(
                                                      seconds: 2),
                                                ),
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                isSubscribed
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: isSubscribed
                                                    ? Colors.red
                                                    : (int.tryParse(controller
                                                                    .gspots) ??
                                                                0) ==
                                                            0
                                                        ? Colors.grey
                                                        : null,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                  isSubscribed
                                                      ? "Desuscribir"
                                                      : "Suscribir",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: colorName,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ]);
                                }))
                            : Text(""),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    )),
              ))
        ],
      )),
    );
  }
}
