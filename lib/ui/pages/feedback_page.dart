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
    final double starSize = 30.0;
    final Color starColor = AppColors.textPrimary;
    final getAllFeedbacksFromAEUseCase =
        Get.find<GetAllFeedbacksFromAnEventUseCase>();
    final textSize = 10.0;
    final controller = Get.find<FeedbackPageController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calificaciones y comentarios",
            style: TextStyle(fontSize: 20),
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
                                    controller.filtro2 == "MejorVal"
                                        ? "Mejor valoradas"
                                        : "Peor valoradas",
                                    style: TextStyle(fontSize: textSize),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    );
                  }))),
          Expanded(
            child: Obx(() => SizedBox(
                  // Altura fija
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
          ),
          Center(
              child: ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 400,
                            child: Center(
                                child: Form(
                                    key: _formKey,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 20, left: 20, right: 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Califica y deja tu comentario",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Obx(() {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .updateActualScore(
                                                                1);
                                                      },
                                                      child: Icon(
                                                        controller.actualScore >=
                                                                1
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: starColor,
                                                        size: starSize,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .updateActualScore(
                                                                2);
                                                      },
                                                      child: Icon(
                                                        controller.actualScore >=
                                                                2
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: starColor,
                                                        size: starSize,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .updateActualScore(
                                                                3);
                                                      },
                                                      child: Icon(
                                                        controller.actualScore >=
                                                                3
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: starColor,
                                                        size: starSize,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .updateActualScore(
                                                                4);
                                                      },
                                                      child: Icon(
                                                        controller.actualScore >=
                                                                4
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: starColor,
                                                        size: starSize,
                                                      )),
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .updateActualScore(
                                                                5);
                                                      },
                                                      child: Icon(
                                                        controller.actualScore >=
                                                                5
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: starColor,
                                                        size: starSize,
                                                      )),
                                                ],
                                              );
                                            }),
                                            TextFormField(
                                              controller: controller2,
                                              style: TextStyle(fontSize: 12),
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      "Ingresa el título de tu comentario"),
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                                  hintText:
                                                      "Ingresa el comentario"),
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Por favor ingresa algo";
                                                }
                                                if (value.length > 300) {
                                                  return "Por favor ingresa un comentario más corto";
                                                }
                                                return null;
                                              },
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        // mandar al controlador

                                                        // cerrar el modal despues de enviar
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Text("Comentar")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancelar")),
                                              ],
                                            ),
                                          ],
                                        )))),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.reviews,
                    color: principal,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  label: Text("Deja tu opinión",
                      style: TextStyle(
                          fontSize: 10, color: AppColors.textPrimary))))
        ]));
  }
}
