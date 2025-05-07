import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/use_cases/get_categories.dart';
import 'package:confhub/ui/widgets/dotted_bg.dart';
import 'package:confhub/ui/widgets/enventLines/event_category.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class EventLines extends StatelessWidget {
  final getCategories = Get.find<GetCategories>();

  EventLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.background ,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          title: Text(
            "Eventos por categoría",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 25,
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
              ),
            ),
          ],
        ));
  }
}
