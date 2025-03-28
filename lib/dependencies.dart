import 'package:get/get.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/data/repositories/event_repository_impl.dart';
import 'package:confhub/domain/repositories/event_repository.dart';
import 'package:confhub/domain/use_cases/get_all_events.dart';

void initDependencies() {
  // Inyección de dependencias
  Get.put<EventLocalDataSource>(EventLocalDataSource()); // Fuente de datos
  Get.put<EventRepository>(EventRepositoryImpl(Get.find())); // Repositorio
  Get.put<GetAllEventsUseCase>(GetAllEventsUseCase(Get.find())); // Caso de uso
}
