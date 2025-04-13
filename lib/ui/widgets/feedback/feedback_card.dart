

import 'package:confhub/core/colors.dart';
import 'package:confhub/ui/controllers/feedback_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackCard extends StatelessWidget {
  final String title;
  final String comment;
  final String date; //  solo la fecha (YYYY-MM-DD)
  final String time; //  solo la hora (HH:MM)
  final int eventid;
  final double score;
  final Color colorFBC;
  final int likes;
  final int dislikes;
  final int feedbackid;

  const FeedbackCard(
      {super.key,
      required this.title,
      required this.comment,
      required this.date,
      required this.time,
      required this.eventid,
      required this.score,
      required this.colorFBC,
      required this.likes,
      required this.dislikes,
      required this.feedbackid});

  @override
  Widget build(BuildContext context) {
    final double starSize = 20.0;
    final Color starColor = Colors.yellowAccent;
    final feedbackController =
        Get.find<FeedbackCardController>(tag: "$feedbackid");

    return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
        height: 150,
        child: Stack(
          children: [
             Container(
              height: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(children: [
                Expanded(
                    flex: 3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                        ])),
                Expanded(
                    child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    score >= 1
                        ? Icon(
                            Icons.star_rounded,
                            color: starColor,
                            size: starSize,
                          )
                        : Text(""),
                    score >= 2
                        ? Icon(
                            Icons.star_rounded,
                            color: starColor,
                            size: starSize,
                          )
                        : Text(""),
                    score >= 3
                        ? Icon(
                            Icons.star_rounded,
                            color: starColor,
                            size: starSize,
                          )
                        : Text(""),
                    score >= 4
                        ? Icon(
                            Icons.star_rounded,
                            color: starColor,
                            size: starSize,
                          )
                        : Text(""),
                    score == 5
                        ? Icon(
                            Icons.star_rounded,
                            color: starColor,
                            size: starSize,
                          )
                        : Text(""),
                  ])
                ]))
              ]),
            ),
            Positioned.fill(
                top: 40,
                child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    height: 100,
                    decoration: BoxDecoration(
                        color: colorFBC,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            comment,
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textPrimary),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          feedbackController
                                              .likeAFeedback(eventid);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up,
                                              size: 10,
                                              color:
                                                  feedbackController.isLiked()
                                                      ? AppColors.background
                                                      : AppColors.textPrimary,
                                            ),
                                             int.parse(feedbackController.likes) != 0  ?
                                            Text(
                                              feedbackController.likes,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: feedbackController
                                                          .isLiked()
                                                      ? AppColors.background
                                                      : AppColors.textPrimary),
                                            ): Text("")
                                          ],
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          feedbackController
                                              .dislikeAFeedback(eventid);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_down,
                                              size: 10,
                                              color: feedbackController
                                                      .isDisliked()
                                                  ? AppColors.background
                                                  : AppColors.textPrimary,
                                            ),
                                    int.parse(feedbackController.dislikes) != 0  ?
                                            Text(
                                              feedbackController.dislikes,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: feedbackController
                                                          .isDisliked()
                                                      ? AppColors.background
                                                      : AppColors.textPrimary),
                                            ) : Text("")
                                          ],
                                        ))
                                  ],
                                );
                              }),
                              Text("$time $date",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textPrimary))
                            ],
                          ),
                        ])))
          ],
        ));
  }
}
