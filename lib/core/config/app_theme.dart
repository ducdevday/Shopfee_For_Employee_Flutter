import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
    appBarTheme: AppBarTheme(
        elevation: 0,
        foregroundColor: AppColor.headingColor,
        backgroundColor: Colors.transparent,
        titleTextStyle: AppStyle.mediumTitleStyleDark,
        surfaceTintColor: Colors.transparent),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(AppColor.primaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimen.smallRadius))),
            side: MaterialStateProperty.all(BorderSide(
                color: AppColor.primaryColor,
                width: 1.5,
                style: BorderStyle.solid)))),
    dividerTheme: DividerThemeData(color: AppColor.disableColor),
  );
}
