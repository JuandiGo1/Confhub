import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/ui/controllers/event_page_controller.dart';
import 'package:confhub/ui/pages/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardEvent extends StatelessWidget {

  final Event event;

  const CardEvent({
    super.key,

    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 0),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Ajusta la altura al contenido
        children: [
          // Fondo verde
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: (MediaQuery.of(context).size.width > 700)
                              ? 18
                              : 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Acción al presionar el ícono
                      },
                      child: Icon(
                        Icons.more_horiz,
                        size: 24,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule,
                            color: AppColors.textPrimary, size: 20),
                        SizedBox(width: 4),
                        Text(
                          event.date,
                          style: TextStyle(
                              color: AppColors.textPrimary, fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      event.time,
                      style:
                          TextStyle(color: AppColors.textPrimary, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: AppColors.textPrimary, size: 20),
                    SizedBox(width: 4),
                    Text(
                      event.location,
                      style:
                          TextStyle(color: AppColors.textPrimary, fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
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
                        eventavgScore: event.avgScore,
                        eventstatus: event.status,
                        eventSessionOrder: event.sessionOrder,
                        numberReviews: event.numberReviews,
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
