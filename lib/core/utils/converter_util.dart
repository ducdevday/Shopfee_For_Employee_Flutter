import 'package:intl/intl.dart';

class ConverterUtil {
  static String formattedDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyy').format(dateTime.toLocal());
  }

  static String formattedDate2(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formattedTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime.toLocal());
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

  static String capitalFirstWord(String s){
    s = s.toLowerCase();
    return "${s[0].toUpperCase()}${s.substring(1)}";
  }
}
