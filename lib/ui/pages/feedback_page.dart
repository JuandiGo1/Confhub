import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/use_cases/get_all_feedbacks_from_an_event.dart';
import 'package:confhub/domain/entities/feedback.dart' as app;
import 'package:confhub/ui/controllers/feedback_card_controller.dart';
import 'package:confhub/ui/controllers/feedback_page_controller.dart';
import 'package:confhub/ui/widgets/feedback/feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackPage extends StatelessWidget {
  final int eventid;
  final Color principal;
  const FeedbackPage(
      {super.key, required this.eventid, required this.principal});

  @override
  Widget build(BuildContext context) {
    final getAllFeedbacksFromAEUseCase =
        Get.find<GetAllFeedbacksFromAnEventUseCase>();
    final textSize = 10.0;
    final controller = Get.find<FeedbackPageController>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Calificaciones y comentarios"),
          backgroundColor: principal,
        ),
        backgroundColor: AppColors.background,
        body: Column(children: [
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Filtrar por",
                            style: TextStyle(fontSize: textSize)),
                        GestureDetector(
                            onTap: () {

                              if (controller.filtro1 == "Recientes") {
                                controller.changeFiltro1("Antiguos");
                              } else {
                                controller.changeFiltro1("Recientes");
                              }
                               controller.changeFiltro(controller.filtro1);
                            },
                            child: Container(
                                padding: EdgeInsets.only(
                                    right: 2, left: 2, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: controller.filtroSelected ==
                                            controller.filtro1
                                        ? Colors.deepPurple
                                        : principal),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.arrow_upward_rounded,
                                        size: 10, weight: 20),
                                    Icon(
                                      Icons.arrow_downward_rounded,
                                      size: 10,
                                      weight: 20,
                                    ),
                                    Text(
                                      controller.filtro1,
                                      style: TextStyle(fontSize: textSize),
                                    ),
                                  ],
                                ))),
                        GestureDetector(
                            onTap: () {

                              if (controller.filtro2 == "MejorVal") {
                                controller.changeFiltro2("PeorVal");
                              } else {
                                controller.changeFiltro2("MejorVal");
                              }
                              controller.changeFiltro(controller.filtro2);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: 2, left: 2, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: controller.filtroSelected ==
                                          controller.filtro2
                                      ? Colors.deepPurple
                                      : principal),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.arrow_upward_rounded,
                                      size: 10, weight: 20),
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    size: 10,
                                    weight: 20,
                                  ),
                                  Text(
                                    controller.filtro2 == "MejorVal" ? "Mejor valoradas":"Peor valoradas",
                                    style: TextStyle(fontSize: textSize),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    );
                  }))),
          Expanded(
            child: Obx (() => SizedBox(
              // Altura fija
              child: FutureBuilder<List<app.Feedback>>(
                future: getAllFeedbacksFromAEUseCase.call(eventid, controller.filtroSelected),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error al cargar feedbacks'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay feedbacks disponibles'));
                  }

                  final feedbacks = snapshot.data!;
                  //MAPEANDO Feedbacks
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: feedbacks.length,
                    itemBuilder: (context, index) {
                      final feedback = feedbacks[index];

                      Get.put<FeedbackCardController>(
                          FeedbackCardController(
                              initialLikes: feedback.likes,
                              initialDislikes: feedback.dislikes),
                          tag: "${feedback.feedbackid}");

                      return SizedBox(
                          width: 370, // Define un ancho para los elementos
                          child: FeedbackCard(
                            title: feedback.title,
                            comment: feedback.comment,
                            date: feedback.date,
                            time: feedback.time,
                            eventid: eventid,
                            score: feedback.score,
                            colorFBC: principal,
                            likes: feedback.likes,
                            dislikes: feedback.dislikes,
                            feedbackid: feedback.feedbackid,
                          ));
                    },
                  );
                },
              ),
            )),
          )
        ]));
  }
}
