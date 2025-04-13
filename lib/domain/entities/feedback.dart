class Feedback {
  String title;
  String comment;
  DateTime dateTime;
  String date; //  solo la fecha (YYYY-MM-DD)
  String time; //  solo la hora (HH:MM)
  int eventid;
  double score;
  int likes;
  int dislikes;
  int feedbackid;

  Feedback({
    required this.title,
    required this.comment,
    required this.dateTime,
    required this.date,
    required this.eventid,
    required this.score,
    required this.time,
    required this.likes,
    required this.dislikes,
    required this.feedbackid,
  });
}
