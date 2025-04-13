import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  String formattedDate = DateFormat('E, d MMM', 'es_ES').format(dateTime);
  return toBeginningOfSentenceCase(formattedDate)!;
}

String formatDate2(DateTime date) {
  String formattedDate = DateFormat('E, d MMM yy', 'es_ES').format(date);
  return toBeginningOfSentenceCase(formattedDate)!;
}
