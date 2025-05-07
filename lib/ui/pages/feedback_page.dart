import 'dart:developer';

import 'package:confhub/core/colors.dart';

import 'package:confhub/data/sources/shared_prefs/local_preferences.dart';
import 'package:confhub/domain/use_cases/delete_a_feedback.dart';
import 'package:confhub/domain/use_cases/get_all_feedbacks_from_an_event.dart';
import 'package:confhub/domain/entities/feedback.dart' as app;
import 'package:confhub/domain/use_cases/make_a_feedback.dart';

import 'package:confhub/domain/use_cases/update_a_feedback.dart';
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
    final deleteAfeedback = Get.find<DeleteAFeedbackUseCase>();
    final controller = Get.find<FeedbackPageController>();
    final double starSize = 30.0;
    final Color starColor = AppColors.textPrimary;
    final getAllFeedbacksFromAEUseCase =
        Get.find<GetAllFeedbacksFromAnEventUseCase>();
    final textSize = 10.0;

    final makeAFeedbackUsecase = Get.find<MakeAFeedbackUseCase>();
    final updateAFeedbackUsecase = Get.find<UpdateAFeedbackUseCase>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();
    final local = LocalPreferences();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calificaciones y comentarios",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
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
                                        ? AppColors.primary
                                        : principal),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [

                                    Icon(
                                      Icons.arrow_upward_rounded,
                                      size: 10,
                                      weight: 20,
                                      color: Colors.white,
                                    ),

                                    Icon(
                                      Icons.arrow_downward_rounded,
                                      size: 10,
                                      weight: 20,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      controller.filtro1,

                                      style: TextStyle(
                                          fontSize: textSize,
                                          color: Colors.white),

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
                                      ? AppColors.primary
                                      : principal),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [

                                  Icon(
                                    Icons.arrow_upward_rounded,
                                    size: 10,
                                    weight: 20,
                                    color: Colors.white,
                                  ),
                               
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    size: 10,
                                    weight: 20,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    controller.filtro2 == "MejorVal"
                                        ? "Mejor valoradas"
                                        : "Peor valoradas",

                                    style: TextStyle(
                                        fontSize: textSize,
                                        color: Colors.white),

                                  ),
                                ],
                              ),
                            ))
                      ],
                    );
                  }))),
          Expanded(
            child: Obx(() => SizedBox(
                  child: FutureBuilder<List<app.Feedback>>(
                    future: getAllFeedbacksFromAEUseCase.call(
                        eventid, controller.filtroSelected),
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
                      log("$feedbacks");
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemCount: feedbacks.length,
                        itemBuilder: (context, index) {
                          final feedback = feedbacks[index];

                          Get.put<FeedbackCardController>(
                            FeedbackCardController(
                                initialLikes: feedback.likes,
                                initialDislikes: feedback.dislikes,
                                eventid: eventid,
                                feedbackid: feedback.feedbackid),
                            tag: "${feedback.feedbackid}",
                          );

                          // Obtener el feedbackId del usuario actual desde el almacenamiento
                          return FutureBuilder<List<String>?>(
                            future: local.retrieveData<List<String>>(
                                'feedbackid/$eventid'),
                            builder: (context, snapshotFeedbackId) {
                              final card = Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                                ),
                              );

                              if (!snapshotFeedbackId.hasData) {
                                return card; // Espera si no está listo
                              }

                              final feedbackids = snapshotFeedbackId.data ?? [];

                              log("$feedbackids");

                              // Verifica si el feedback es del usuario actual
                              final isOwner = feedbackids
                                  .contains("${feedback.feedbackid}");

                              log("$isOwner");

                              // Si no es del usuario actual, solo se muestra la tarjeta sin eliminar

                              if (!isOwner) return card;

                              return Dismissible(
                                key: Key(feedback.feedbackid.toString()),
                                direction: DismissDirection.horizontal,
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: Colors.blue,
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: Colors.red,
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    // Acción: Actualizar
                                    controller2.text = feedback.title;
                                    controller3.text = feedback.comment;
                                    controller
                                        .updateActualScore(feedback.score);
                                    controller.setFeedbacksid(
                                        "${feedback.feedbackid}");
                                    controller.wasSent();

                                    showFeedbackModal(context,
                                        formKey: formKey,
                                        controller2: controller2,
                                        controller3: controller3,
                                        eventid: eventid,
                                        controller: controller,
                                        makeAFeedbackUsecase:
                                            makeAFeedbackUsecase,
                                        updateAFeedbackUsecase:
                                            updateAFeedbackUsecase,
                                        local: local,
                                        starColor: starColor,
                                        starSize: starSize,
                                        feedbackid: feedback.feedbackid,
                                        status: "old");

                                    return false; // No eliminar, solo abrir el modal
                                  } else if (direction ==
                                      DismissDirection.endToStart) {
                                    // Acción: Eliminar
                                    final result = await deleteAfeedback
                                        .call(feedback.feedbackid);
                                    final contentText = result
                                        ? 'Comentario eliminado'
                                        : 'Comentario no eliminado';

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(contentText),
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                    return result;
                                  }
                                  return false;
                                },
                                child: card,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                )),
          ),
          Center(

              child: FloatingActionButton(
            onPressed: () {
              showFeedbackModal(
                context,
                formKey: formKey,
                controller2: controller2,
                controller3: controller3,
                eventid: eventid,
                controller: controller,
                makeAFeedbackUsecase: makeAFeedbackUsecase,
                updateAFeedbackUsecase: updateAFeedbackUsecase,
                local: local,
                starColor: starColor,
                starSize: starSize,
              );
            },
            child: Icon(
              Icons.reviews,
              color: principal,
            ),
          ))
        ]));
  }
}

void showFeedbackModal(BuildContext context,
    {required GlobalKey<FormState> formKey,
    required TextEditingController controller2,
    required TextEditingController controller3,
    required int eventid,
    required FeedbackPageController controller,
    required MakeAFeedbackUseCase makeAFeedbackUsecase,
    required UpdateAFeedbackUseCase updateAFeedbackUsecase,
    required LocalPreferences local,
    required Color starColor,
    required double starSize,
    int feedbackid = 0,
    String status = "new"}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 400,
        child: Center(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Califica y deja tu comentario",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        int starIndex = index + 1;
                        return GestureDetector(
                          onTap: () {
                            controller.updateActualScore(starIndex);
                          },
                          child: Icon(
                            controller.actualScore >= starIndex
                                ? Icons.star
                                : Icons.star_border,
                            color: starColor,
                            size: starSize,
                          ),
                        );
                      }),
                    );
                  }),
                  TextFormField(
                    controller: controller2,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ingresa el título de tu comentario",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El título es necesario";
                      }
                      if (value.length > 70) {
                        return "Por favor ingresa un título más corto";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controller3,
                    maxLines: 5,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ingresa el comentario",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa algo";
                      }
                      if (value.length > 300) {
                        return "Por favor ingresa un comentario más corto";
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            app.Feedback? result;
                            bool resp = false;

                            if (status == "new") {
                              final feedback = {
                                "title": controller2.text,
                                "comment": controller3.text,
                                "score": controller.actualScore,
                                "eventid": eventid,
                              };
                              result =
                                  await makeAFeedbackUsecase.call(feedback);

                              controller
                                  .setFeedbacksid("${result!.feedbackid}");

                              await local.storeData(
                                'feedbackid/$eventid',
                                controller.feedbackids,
                              );
                            } else {
                              final feedback = {
                                "title": controller2.text,
                                "comment": controller3.text,
                                "score": controller.actualScore,
                                "eventid": eventid,
                              };

                              resp = await updateAFeedbackUsecase.call(
                                feedbackid,
                                feedback,
                              );

                              final contentText = resp
                                  ? 'Comentario Actualizado'
                                  : 'Comentario no Actualizado';

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(contentText),
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }

                            controller.wasSent();
                            controller.changeFiltro("");
                            controller2.clear();
                            controller3.clear();
                            controller.updateActualScore(0);

                            if (context.mounted) Navigator.pop(context);
                          }
                        },
                        child: Text("Comentar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller2.clear();
                          controller3.clear();
                          controller.updateActualScore(0);
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
