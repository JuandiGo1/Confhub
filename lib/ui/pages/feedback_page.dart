import 'package:confhub/core/colors.dart';
import 'package:confhub/domain/use_cases/get_all_feedbacks_from_an_event.dart';
import 'package:confhub/domain/entities/feedback.dart' as app;
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

    return Scaffold(
        appBar: AppBar(
          title: Text("Calificaciones y comentarios"),
          backgroundColor: principal,
        ),
        backgroundColor: AppColors.background,
        body: Expanded(
          child: SizedBox(
            // Altura fija
            child: FutureBuilder<List<app.Feedback>>(
              future: getAllFeedbacksFromAEUseCase.call(eventid, "Asc"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar feedbacks'));
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
                    return SizedBox(
                        width: 370, // Define un ancho para los elementos
                        child: FeedbackCard(
                            title: feedback.title,
                            comment: feedback.comment,
                            date: feedback.date,
                            time: feedback.time,
                            eventid: eventid,
                            score: feedback.score,
                            colorFBC: principal));
                  },
                );
              },
            ),
          ),
        ));
  }
}
