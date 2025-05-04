import 'package:confhub/domain/use_cases/get_all_events.dart';
import 'package:get/get.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/use_cases/get_events_category.dart';

class EventLinesController extends GetxController {
  final GetEventsByCategory getEventsByCategory;
  final getAllEventsUseCase = Get.find<GetAllEventsUseCase>();

  EventLinesController({required this.getEventsByCategory});

  var selectedCategory = ''.obs; // Categoría seleccionada
  var filteredEvents = <Event>[].obs; // Eventos filtrados por categoría
  var isLoading = false.obs; // Estado de carga
  var hasError = false.obs; // Estado de error

  void selectCategory(String category) async {
    selectedCategory.value = category;
    await fetchEventsByCategory();
  }

  Future<void> fetchEventsByCategory() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      if (selectedCategory.value.isEmpty) {
        // Si no hay categoría seleccionada, obtener todos los eventos
        final events = await getAllEventsUseCase.call();
        filteredEvents.assignAll(events);
      } else {
        // Si hay una categoría seleccionada, obtener eventos por categoría
        final events = await getEventsByCategory.call(selectedCategory.value);
        filteredEvents.assignAll(events);
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
} 