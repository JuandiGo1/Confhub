import 'package:confhub/core/colors.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  final String title;
  final String comment;
  final String date; //  solo la fecha (YYYY-MM-DD)
  final String time; //  solo la hora (HH:MM)
  final int eventid;
  final double score;
  final Color colorFBC;

  const FeedbackCard(
      {super.key,
      required this.title,
      required this.comment,
      required this.date,
      required this.time,
      required this.eventid,
      required this.score,
      required this.colorFBC});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(color: AppColors.backgroundSecondary),
                child: Row(
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 20, color: AppColors.textPrimary),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.star_rounded, color: Colors.yellow,),
                    Text(
                      "$score",
                      style:
                          TextStyle(fontSize: 20, color: AppColors.textPrimary),
                    )
                  ],
                ))),
        Positioned.fill(
            top: 60,
            child: Expanded(
                child: Container(
              decoration: BoxDecoration(color: colorFBC),
              child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 10, color: AppColors.textPrimary),
                    ),
            )))
      ],
    );
  }
}
