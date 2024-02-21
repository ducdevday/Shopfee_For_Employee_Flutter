import 'package:intl/intl.dart';

class FormatUtil {
  static String formattedDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyy').format(dateTime.toLocal());
  }

  static String formattedDate2(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formattedBirthDay(DateTime? dateTime) {
    if (dateTime == null) return "";
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formattedTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime.toLocal());
  }

  static String formattedQueryString(String s) {
    return s.trim().toLowerCase().replaceAll(' ', '');
  }

  static String formattedMoney(num number) {
    return "${NumberFormat.decimalPattern().format(number)}đ";
  }

  static String formattedArrayString(List<String> arr) {
    List<String> results = [];
    for (var name in arr) {
      results.add(name);
    }
    return results.join(", ");
  }

  static String capitalFirstWord(String s) {
    s = s.toLowerCase();
    return "${s[0].toUpperCase()}${s.substring(1)}";
  }

  static String formatOriginalPhone(String? phone) {
    if (phone == null) {
      return "";
    }
    StringBuffer result = StringBuffer();

    for (int i = 0; i < phone.length; i++) {
      if (RegExp(r'[0-9]').hasMatch(phone[i])) {
        result.write(phone[i]);
      }
    }
    return result.toString();
  }
}
