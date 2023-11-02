import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
    appBarTheme: AppBarTheme(
      elevation: 0,
      foregroundColor: AppColor.headingColor,
      backgroundColor: Colors.transparent,
      titleTextStyle: AppStyle.mediumTitleStyleDark,
    ),
    scaffoldBackgroundColor: Colors.white
  );
}