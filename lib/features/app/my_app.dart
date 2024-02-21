import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopfeeforemployee/core/config/app_theme.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/router/app_router.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/core/utils/global_keys.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/features/employee/presentation/employee.dart';
import 'package:shopfeeforemployee/features/home/presentation/home.dart';
import 'package:shopfeeforemployee/features/login/presentation/login.dart';
import 'package:shopfeeforemployee/features/notification_permission/notify_permission_page.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/order_detail.dart';

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
          NavigationUtil.pushNamed(OrderDetailPage.route,
              arguments: notificationResponse.payload);
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ServiceLocator.sl<EmployeeBloc>()
              ..add(EmployeeLoadInformation())),
      ],
      child: MaterialApp(
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
      ),
    );
  }

  String getStartRoute() {
    if (SharedService.getIsFirstTime()) {
      return NotifyPermissionPage.route;
    } else if (SharedService.getEmployeeId() == null) {
      return LoginPage.route;
    }
    return HomePage.route;
  }
}
