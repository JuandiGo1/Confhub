import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/use_cases/get_events_category.dart';
import 'package:confhub/ui/widgets/enventLines/card_event.dart';
import 'package:confhub/ui/widgets/enventLines/separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventCategory extends StatelessWidget {
  final String category;
  final int colorCode;
  EventCategory({super.key, required this.category, required this.colorCode});

  final getEventsByCategory = Get.find<GetEventsByCategory>();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              category,
              style: TextStyle(fontSize: 25, color: AppColors.textPrimary),
            )),
        SeparatorWithDot(
          lineColor: Colors.black,
          dotColor: Colors.black,
          thickness: 2,
        ),
        FutureBuilder(
            future: getEventsByCategory.call(category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              } else if (snapshot.hasError) {
                return Text('Error.');
              }

              List<Event> categories = snapshot.data ?? [];
              return SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics:
                      BouncingScrollPhysics(), // Opcional, da un efecto suave
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: categories.map((e) {
                        return CardEvent(
                            eventAmount: e.attendees,
                            title: e.title,
                            date: e.date,
                            color: colorCode);
                      }).toList()),
                ),
              );
            })
      ],
    );
  }
}
