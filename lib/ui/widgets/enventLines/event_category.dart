import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/ui/controllers/event_lines_controller.dart';
import 'package:confhub/ui/widgets/enventLines/card_event.dart';
import 'package:confhub/ui/widgets/enventLines/separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventCategory extends StatelessWidget {
  final String category;
  final int colorCode;

  EventCategory({super.key, required this.category, required this.colorCode});

  final EventLinesController controller = Get.find<EventLinesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Event> events = controller.filteredEvents;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.sell_outlined,
                  color: const Color.fromARGB(255, 7, 70, 1),
                  size: 23,
                ),
              ),
              SizedBox(width: 10),
              Text(
                category,
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
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
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: events.map((e) {
                  return CardEvent(event: e, color: colorCode);
                }).toList(),
              ),
            ),
          ),
        ],
      );
    });
  }
}