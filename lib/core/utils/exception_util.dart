import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/errors/app_exception.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/features/no_network/no_network_page.dart';

class ExceptionUtil {
  static void handle(e) {
    print(e.toString());
    EasyLoading.dismiss();
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionError) {
        NavigationUtil.push(const NoNetWorkPage());
      } else {
        EasyLoading.showError("Something went wrong. Please try again!");
      }
    } else if (e is AppException) {
      EasyLoading.showError(
          e.message ?? "Something went wrong. Please try again!");
    } else {
      EasyLoading.showError("Something went wrong. Please try again!");
    }
  }
}
