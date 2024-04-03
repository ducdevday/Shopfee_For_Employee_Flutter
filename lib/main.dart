import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/service/push_noticication_service.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/core/utils/simple_bloc_observer.dart';
import 'package:shopfeeforemployee/features/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  // await FirebaseMessaging.instance.subscribeToTopic("orders");
  await FlutterConfig.loadEnvVariables();
  await SharedService.init();
  await ServiceLocator().init();
  await SharedService.initAppDocPath();
  await PushNotificationService.setUpPushNotification();
  Bloc.observer = BlocObserverUtil();

  runApp(const MyApp());
}
