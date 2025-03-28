import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  String formattedDate = DateFormat('E, d MMM', 'es_ES').format(dateTime);
  return toBeginningOfSentenceCase(formattedDate)!;
}
