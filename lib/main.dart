import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopfeeforemployee/core/common/models/gender.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/features/app/my_app.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedService.init();
  await ServiceLocator().init();
  await _initLocalData();

  runApp(const MyApp());
}

Future<void> _initLocalData() async {
  GlobalData.ins.employeeId = SharedService.getEmployeeId();
  GlobalData.ins.accessToken = SharedService.getAccessToken();
  GlobalData.ins.refreshToken = SharedService.getRefreshToken();
}