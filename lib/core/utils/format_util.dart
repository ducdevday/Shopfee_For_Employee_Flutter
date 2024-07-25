import 'package:intl/intl.dart';

class FormatUtil {
  static String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('MMMM dd, yyy').format(dateTime.toLocal());
  }

  static String formatDate2(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formatDate3(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('dd/MM').format(dateTime.toLocal());
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('hh:mm a').format(dateTime.toLocal());
  }

  static DateTime formatOpenCloseTime(String timeString){
    List<String> timeParts = timeString.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes).toLocal(); // Using
    return dateTime;
  }

  static String formatSQLTime(DateTime time){
    DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(time);
  }

  static String formatQueryString(String? s) {
    if (s == null) {
      return "";
    }
    return s.trim().toLowerCase().replaceAll(' ', '');
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

  static String formatBirthDay(DateTime? dateTime) {
    if (dateTime == null) return "";
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formatMoney(num? price) {
    if (price == null) {
      return "";
    }
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(price);
  }

  static String formatDecimal(num? price) {
    if (price == null) {
      return "";
    }
    final formatter = NumberFormat('#,##0.###', 'vi_VN');
    return formatter.format(price);
  }

  static String formatCoin(num? coin) {
    if (coin == null) {
      return "";
    }
    final formatter = NumberFormat('#,##0.###', 'vi_VN');
    return '${formatter.format(coin)} ${coin > 1 ? "coins" : "coin"}';
  }

  static String formattedArrayString(List<String> arr) {
    List<String> results = [];
    for (var name in arr) {
      results.add(name);
    }
    return results.join(", ");
  }

  static String formatSize(String size) {
    switch (size) {
      case "SMALL":
        return "Small";
      case "MEDIUM":
        return "Medium";
      case "LARGE":
        return "Large";
      default:
        return "One Size";
    }
  }

  static String formatSeconds(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  static String formattedStatisticDatetimeToString(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static DateTime? formattedStatisticStringToDatetime(String? dateString) {
    if (dateString == null) {
      return null;
    }
    return DateTime.parse(dateString);
  }

  static DateTime addOneDay(DateTime dateTime){
    return dateTime.add(Duration(days: 1));
  }
}
