import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';

class ChangePasswordService extends BaseService {
  Future<Response> changePassword(
      String employeeId, String oldPassword, String newPassword) async {
    Map<String, dynamic> body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    final response = await dio.patch(
        "${BaseService.employeePath}/change-password/$employeeId",
        data: body);
    return response;
  }
}
