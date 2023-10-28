import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/utils/global_keys.dart';

class AlertUtil {
  static showToast(String message) {
    return scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColor.primaryColor,
      ),
    );
  }
}