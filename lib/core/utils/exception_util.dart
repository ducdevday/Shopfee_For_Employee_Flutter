import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/utils/alert_util.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/features/no_network/no_network_page.dart';

class ExceptionUtil {
  static void handle(failure) {
    if (failure is ServerFailure) {
      // error from api
      EasyLoading.showError(
          failure.message!, duration: const Duration(milliseconds: 2000));
    }
    else if (failure is NetworkFailure) {
      NavigationUtil.push(page: const NoNetWorkPage());
    }
    else if(failure is UnknownFailure){
      AlertUtil.showToast("Something went wrong");
    }
    else{
      AlertUtil.showToast("Something went wrong");
    }
  }
}