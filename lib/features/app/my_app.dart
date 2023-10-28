import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/config/theme.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/router/app_router.dart';
import 'package:shopfeeforemployee/core/utils/global_keys.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldKey,
      onGenerateRoute: (settings) {
        return AppRouter.onGenerateRoute(settings);
      },
      initialRoute: AppRouter.shippingOrder,
      builder: EasyLoading.init(),
    );
  }

  String getStartRoute() {
    if (GlobalData.ins.employeeId == null) {
      return AppRouter.loginRoute;
    }
    return AppRouter.homeRoute;
  }}
