import 'package:confhub/core/utils/date_formatter.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:get/get.dart';
import 'package:confhub/domain/use_cases/get_all_events.dart';


class CalendarController extends GetxController {
  final GetAllEventsUseCase getAllEventsUseCase;

  CalendarController(this.getAllEventsUseCase);

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxList<Event> allEvents = <Event>[].obs;
  final RxList<Event> eventsForSelectedDay = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void onDaySelected(DateTime day, DateTime focusedDay) {
    selectedDate.value = day;
    filterEventsByDay();
  }

  void fetchEvents() async {
    final events = await getAllEventsUseCase.call();
    allEvents.assignAll(events);
    filterEventsByDay();
  }

  void filterEventsByDay() {
    final selected = formatDate(selectedDate.value);

    final filtered = allEvents.where((event) {
      final eventDate = event.date;
      return eventDate == selected;
    }).toList();

    eventsForSelectedDay.assignAll(filtered);
  }
}
