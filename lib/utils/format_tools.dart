import 'package:intl/intl.dart';

class FormatTools {
  static String formatDateToString(DateTime date) {
    try {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formattedDate = formatter.format(date);
      return formattedDate;
    } catch (e) {
      print('Error formatting date: $e');
      return date.toString();
    }
  }
}