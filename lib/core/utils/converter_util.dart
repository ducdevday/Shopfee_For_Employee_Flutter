import 'package:intl/intl.dart';

class ConverterUtil {
  static String formattedDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyy').format(dateTime);
  }

  static String formattedTime(DateTime dateTime) {
    return DateFormat('kk:mm a').format(dateTime);
  }

  static String formattedQueryString(String s) {
    return s.trim().toLowerCase().replaceAll(' ', '');
  }

  static String formattedMoney(double number) {
    return "${NumberFormat.decimalPattern().format(number)}đ";
  }

  static String formattedArrayString(List<String> arr) {
    List<String> results = [];
    for (var name in arr) {
      results.add(name);
    }
    return results.join(", ");
  }
}
