import 'package:date_format/date_format.dart';

class DateUtils {
  static String getDateFormat(DateTime date) {
    if (date == null) {
      return formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
    }
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
  }
}
