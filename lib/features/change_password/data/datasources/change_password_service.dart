import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';

class ChangePasswordService {
  Future<Response> changePassword(
      String employeeId, String oldPassword, String newPassword) async {
    Map<String, dynamic> body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    final response = await DioService.instance.patch(
        "${DioService.employeePath}/change-password/$employeeId",
        data: body);
    return response;
  }
}
