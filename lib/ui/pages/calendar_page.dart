import 'package:confhub/core/colors.dart';
import 'package:confhub/ui/widgets/timeline/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../domain/entities/event.dart';
import '../controllers/calendar_controller.dart';

class CalendarPage extends StatelessWidget {
  CalendarController get controller => Get.put(
        CalendarController(
            Get.find()), // Asume que ya hiciste Get.put(GetAllEventsUseCase())
      );

  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendario de Eventos')),
      body: Column(
        children: [
          Obx(() => TableCalendar(
                focusedDay: controller.selectedDate.value,
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                selectedDayPredicate: (day) =>
                    isSameDay(day, controller.selectedDate.value),
                onDaySelected: controller.onDaySelected,
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColors.background, // Día actual
                    shape: BoxShape.circle,
                  ),
                ),
              )),
          SizedBox(height: 16),
          Obx(() {
            final eventos = controller.eventsForSelectedDay;
            if (eventos.isEmpty) {
              return Text("No hay eventos para este día.");
            }

            return Expanded(
              child: ListView.builder(
                itemCount: eventos.length,
                itemBuilder: (_, index) {
                  final Event event = eventos[index];
                  return EventCard(
                    event: event,
                    isToday: isSameDay(
                        controller.selectedDate.value, DateTime.now()),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
