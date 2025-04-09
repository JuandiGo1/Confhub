import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/use_cases/get_categories.dart';
import 'package:confhub/ui/widgets/enventLines/event_category.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class EventLines extends StatelessWidget {
  final getCategories = Get.find<GetCategories>();

  EventLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lineas de eventos",
              style: TextStyle(color: AppColors.background)),
          backgroundColor: const Color.fromRGBO(23, 42, 58, 1),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.background,
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
                          Column(
                              spacing: 22,
                              children: categories.asMap().entries.map((c) {
                                return EventCategory(
                                  category: c.value,
                                  colorCode: (c.key + 1) % 3,
                                );
                              }).toList()),
                        ],
                      );
                    })),
          ),
        ));
  }
}
