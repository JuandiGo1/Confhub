import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  return DateFormat('E, d MMM', 'es_ES').format(dateTime);
}
