import 'package:confhub/data/repositories/feedback_repository_impl.dart';
import 'package:confhub/data/sources/event_remote_data_source.dart';
import 'package:confhub/data/sources/feedback_local_data_source.dart';
import 'package:confhub/data/sources/feedback_remote_data_source.dart';
import 'package:confhub/domain/repositories/feedback_repository.dart';
import 'package:confhub/domain/use_cases/delete_a_feedback.dart';
import 'package:confhub/domain/use_cases/dislike_a_feedback.dart';
import 'package:confhub/domain/use_cases/get_all_feedbacks_from_an_event.dart';
import 'package:confhub/domain/use_cases/get_categories.dart';
import 'package:confhub/domain/use_cases/get_events_category.dart';
import 'package:confhub/domain/use_cases/get_today_events.dart';
import 'package:confhub/domain/use_cases/like_a_feedback.dart';
import 'package:confhub/domain/use_cases/make_a_feedback.dart';
import 'package:confhub/domain/use_cases/send_feedback.dart';
import 'package:confhub/domain/use_cases/subscribe_an_event.dart';
import 'package:confhub/domain/use_cases/undislike_a_feedback.dart';
import 'package:confhub/domain/use_cases/unlike_a_feedback.dart';
import 'package:confhub/domain/use_cases/unsuscribe_an_event.dart';
import 'package:confhub/domain/use_cases/get_all_events.dart';
import 'package:confhub/domain/use_cases/get_suscribed_events.dart';
import 'package:confhub/domain/use_cases/get_is_subscribed.dart';
import 'package:confhub/domain/use_cases/update_a_feedback.dart';
import 'package:get/get.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';
import 'package:confhub/data/repositories/event_repository_impl.dart';
import 'package:confhub/domain/repositories/event_repository.dart';
import 'package:confhub/ui/controllers/event_lines_controller.dart';

void initDependencies() {
  // Inyección de dependencias
  Get.put<EventLocalDataSource>(EventLocalDataSource()); // Fuente de datos
  Get.put<EventRemoteDataSource>(
      EventRemoteDataSource(localDataSource: EventLocalDataSource()));
  final eventRepo = EventRepositoryImpl(
    Get.find<EventRemoteDataSource>(),
    Get.find<EventLocalDataSource>(),
  );
  eventRepo.loadSubscribedEvents();
  Get.put<FeedbackRemoteDataSource>(FeedbackRemoteDataSource());
  Get.put<EventRepository>(eventRepo); // Repositorio
  Get.put<GetAllEventsUseCase>(GetAllEventsUseCase(Get.find())); // Caso de uso
  Get.put<GetTodayEventsUseCase>(GetTodayEventsUseCase(Get.find()));
  Get.put<GetCategories>(GetCategories(Get.find()));
  Get.put<GetEventsByCategory>(GetEventsByCategory(Get.find()));
  Get.put<GetSuscribedEventsUseCase>(GetSuscribedEventsUseCase(Get.find()));
  Get.put<UnsubscribeEventUseCase>(UnsubscribeEventUseCase(Get.find()));
  Get.put<SubscribeEventUseCase>(SubscribeEventUseCase(Get.find()));
  Get.put<IsSubscribed>(IsSubscribed(Get.find()));
  Get.put<FeedbackLocalDataSource>(FeedbackLocalDataSource());
  Get.put<FeedbackRepository>(FeedbackRepositoryImpl(Get.find()));
  Get.put<GetAllFeedbacksFromAnEventUseCase>(
      GetAllFeedbacksFromAnEventUseCase(Get.find()));
  Get.put<LikeAFeedbackUseCase>(LikeAFeedbackUseCase(Get.find()));
  Get.put<DislikeAFeedbackUseCase>(DislikeAFeedbackUseCase(Get.find()));
  Get.put<UnLikeAFeedbackUseCase>(UnLikeAFeedbackUseCase(Get.find()));
  Get.put<UnDisLikeAFeedbackUseCase>(UnDisLikeAFeedbackUseCase(Get.find()));
  Get.put<MakeAFeedbackUseCase>(MakeAFeedbackUseCase(Get.find()));
  Get.put<UpdateAFeedbackUseCase>(UpdateAFeedbackUseCase(Get.find()));
  Get.put<DeleteAFeedbackUseCase>(DeleteAFeedbackUseCase(Get.find()));
  Get.put<SendFeedbackUseCase>(SendFeedbackUseCase(Get.find()));
  Get.put<EventLinesController>(
    EventLinesController(getEventsByCategory: Get.find<GetEventsByCategory>()),
  );
}
