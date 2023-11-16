import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopfeeforemployee/core/config/theme.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/router/app_router.dart';
import 'package:shopfeeforemployee/core/utils/global_keys.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initInfoNotify();
    setupMessageNotify();
  }

  void initInfoNotify() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var initialSettings = InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      try {
        if (notificationResponse.payload != null &&
            notificationResponse.payload!.isNotEmpty) {
          NavigationUtil.pushNamed(route: AppRouter.orderDetailRoute,
              args: notificationResponse.payload);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  void setupMessageNotify() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(".................on Message.................");
      print("SenderId: ${message.senderId}");
      print("Title: ${message.notification?.title}");
      print("SenderId: ${message.notification?.body}");
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('shopfee', 'shopfee',
              channelDescription: ' This is shopfee channel description',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              color: Colors.white);
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data["destinationId"]);
    });
  }

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
      // home: ProcessTimelinePage(),
      initialRoute: getStartRoute(),
      builder: EasyLoading.init(),
    );
  }

  String getStartRoute() {
    if(GlobalData.ins.isFirstTime){
      return AppRouter.notifyPermissionRoute;
    }
    else if (GlobalData.ins.employeeId == null) {
      return AppRouter.loginRoute;
    }
    return AppRouter.homeRoute;
  }
}
