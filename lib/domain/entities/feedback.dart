class Feedback {
  String title;
  String comment;
  DateTime dateTime;
  String date; //  solo la fecha (YYYY-MM-DD)
  String time; //  solo la hora (HH:MM)
  int eventid;
  int score;
  int likes;
  int dislikes;
  int feedbackid;
  String? answer;
  String? answerDateTime;

  Feedback(
      {required this.title,
      required this.comment,
      required this.dateTime,
      this.date = "",
      required this.eventid,
      required this.score,
      this.time = "",
      this.likes = 0,
      this.dislikes = 0,
      this.feedbackid = 0,
      this.answer="",
      this.answerDateTime = ""
      });
}
