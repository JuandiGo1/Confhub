import 'package:confhub/domain/use_cases/get_all_feedbacks_from_an_event.dart';
import 'package:confhub/domain/use_cases/get_categories.dart';
import 'package:confhub/domain/use_cases/get_events_category.dart';
import 'package:confhub/domain/use_cases/subscribe_an_event.dart';
import 'package:confhub/domain/use_cases/unsuscribe_an_event.dart';
import 'package:confhub/domain/use_cases/get_all_events.dart';
import 'package:confhub/domain/use_cases/get_suscribed_events.dart';
import 'package:confhub/domain/use_cases/get_is_subscribed.dart';
import 'package:get/get.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/data/repositories/event_repository_impl.dart';
import 'package:confhub/domain/repositories/event_repository.dart';

void initDependencies() {
  // Inyección de dependencias
  Get.put<EventLocalDataSource>(EventLocalDataSource()); // Fuente de datos
  Get.put<EventRepository>(EventRepositoryImpl(Get.find())); // Repositorio
  Get.put<GetAllEventsUseCase>(GetAllEventsUseCase(Get.find())); // Caso de uso
  Get.put<GetCategories>(GetCategories(Get.find()));
  Get.put<GetEventsByCategory>(GetEventsByCategory(Get.find()));
  Get.put<GetSuscribedEventsUseCase>(GetSuscribedEventsUseCase(Get.find()));
  Get.put<UnsubscribeEventUseCase>(UnsubscribeEventUseCase(Get.find()));
  Get.put<SubscribeEventUseCase>(SubscribeEventUseCase(Get.find()));
  Get.put<IsSubscribed>(IsSubscribed(Get.find()));
  Get.put<GetAllFeedbacksFromAnEventUseCase>(Get.find());
}
