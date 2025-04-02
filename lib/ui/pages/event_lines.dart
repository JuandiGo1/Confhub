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
          title: Text("Lineas de eventos"),
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.primary,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                      spacing: 10,
                        children: categories.map((c) {
                      return EventCategory(category: c);
                    }).toList());
                  })),
        ));
  }
}
