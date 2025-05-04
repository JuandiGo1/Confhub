import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/use_cases/get_categories.dart';
import 'package:confhub/domain/use_cases/get_events_category.dart';
import 'package:confhub/ui/controllers/event_lines_controller.dart';
import 'package:confhub/ui/widgets/dotted_bg.dart';
import 'package:confhub/ui/widgets/enventLines/card_event.dart';
import 'package:confhub/ui/widgets/home/upcoming_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventLines extends StatelessWidget {
  final getCategories = Get.find<GetCategories>();
  final EventLinesController controller = Get.put(
    EventLinesController(getEventsByCategory: Get.find<GetEventsByCategory>()),
  );

  EventLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        title: Text(
          "Eventos por categoría",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          const DottedBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: FutureBuilder(
                    future: getCategories.call(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading');
                      } else if (snapshot.hasError) {
                        return Text('Error.');
                      }

                      List<String> categories = snapshot.data ?? [];
                      return Column(
                        children: [
                          Wrap(
                            spacing: 8,
                            children: categories.map((category) {
                              return Obx(() => ChoiceChip(
                                    label: Text(category),
                                    selected:
                                        controller.selectedCategory.value ==
                                            category,
                                    onSelected: (isSelected) {
                                      if (isSelected) {
                                        controller.selectCategory(category);
                                      }
                                    },
                                  ));
                            }).toList(),
                          ),
                          SizedBox(height: 20),
                          Obx(() {
                            if (controller.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else if (controller.hasError.value) {
                              return Text("Error loading events.");
                            } else if (controller.filteredEvents.isEmpty) {
                              return Text("No events found");
                            } else {
                              return Column(
                                children: controller.filteredEvents
                                    .map((event) => CardEvent(
                                          title: event.title,
                                          date: event.date,
                                          time: event.time,
                                          category: event.category,
                                          speakerAvatar: event.speakerAvatar,
                                          event: event,
                                        ))
                                    .toList(),
                              );
                            }
                          }),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
