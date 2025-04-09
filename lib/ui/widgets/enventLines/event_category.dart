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
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.sell_outlined, color: const Color.fromARGB(255, 7, 70, 1), size: 23,),
            ),
            SizedBox(width: 10),
            Text(
              category,
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize:23, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SeparatorWithDot(
            lineColor: AppColors.title,
            dotColor: Colors.black,
            thickness: 5,
          ),
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
                        return CardEvent(event: e, color: colorCode);
                      }).toList()),
                ),
              );
            })
      ],
    );
  }
}
