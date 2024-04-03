import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';

class NotifyPermissionService {
  Future<Response> saveFCMTokenToDB(String? employeeId, String? fcmToken) async {
    Map<String, dynamic> body = {
      "employeeId": employeeId,
      "token": fcmToken,
    };
    final response = await DioService.instance
        .post("${DioService.notificationPath}/employee", data: body);
    return response;
  }
}
