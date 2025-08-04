import 'package:intl/intl.dart';

class CommonUtils {
  static String formatDate(String formatString, String date) {
    DateTime localDate = DateTime.parse(date);
    return DateFormat(formatString).format(localDate);
  }
}
