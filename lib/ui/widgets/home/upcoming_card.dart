import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';
import 'package:confhub/ui/pages/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpcomingCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String category;
  final String speakerAvatar;
  final Event event;

  const UpcomingCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.category,
    required this.speakerAvatar,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 0),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        //border: Border.all(color: const Color.fromARGB(255, 243, 243, 243), width: 5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Fondo verde
          Flexible(
            child: Container(
              //height: 180,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(title,
                            style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: (MediaQuery.of(context).size.width > 700) ? 18 : 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      GestureDetector(
                        onTap: () {
                          //
                        },
                        child: Icon(
                          Icons.more_horiz,
                          size: 24,
                          color: AppColors.secondary,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      if (MediaQuery.of(context).size.height > 700) ...[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.sell_outlined,
                                  color: Colors.white, size: 12),
                              Text(
                                category,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule,
                        color: AppColors.textPrimary, size: 20),
                    SizedBox(width: 4),
                    Text(date,
                        style: TextStyle(
                            color: AppColors.textPrimary, fontSize: 16)),
                  ],
                ),
                Text(time,
                    style:
                        TextStyle(color: AppColors.textPrimary, fontSize: 16)),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    //Para entrega 2 modularizar esta funcionalidad
                    Get.to(
                      () => EventDetailPage(
                        eventTitle: event.title,
                        eventId: event.eventid,
                        eventDate: event.date,
                        eventAttendees: event.attendees,
                        eventCategory: event.category,
                        eventDescription: event.description,
                        eventSpeakerAvatar: event.speakerAvatar,
                        eventTime: event.time,
                        eventSpeakerName: event.speakerName,
                        eventLocation: event.location,
                        eventSpots: event.availableSpots,
                      ),
                      transition: Transition.cupertino,
                    );

                    Get.put<EventPageController>(EventPageController(
                        initialAttendees: event.attendees,
                        initialSpots: event.availableSpots));
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Unirse Ahora",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
