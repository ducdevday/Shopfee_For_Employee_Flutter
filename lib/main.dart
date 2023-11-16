import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/core/utils/simple_bloc_observer.dart';
import 'package:shopfeeforemployee/features/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.subscribeToTopic("orders");
  await SharedService.init();
  await ServiceLocator().init();
  await _initLocalData();
  Bloc.observer = BlocObserverUtil();

  runApp(const MyApp());
}

Future<void> _initLocalData() async {
  GlobalData.ins.isFirstTime = SharedService.getIsFirstTime() ?? true;
  GlobalData.ins.employeeId = SharedService.getEmployeeId();
  GlobalData.ins.accessToken = SharedService.getAccessToken();
  GlobalData.ins.refreshToken = SharedService.getRefreshToken();
}