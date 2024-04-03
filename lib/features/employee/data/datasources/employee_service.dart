import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';

class EmployeeService {
  Future<Response> getEmployee(String employeeId) async {
    final response =
        DioService.instance.get("${DioService.employeePath}/$employeeId");
    return response;
  }

  Future<Response> logout(String fcmTokenId) async {
    Map<String, dynamic> body = {
      "fcmTokenId": fcmTokenId,
    };
    final response = await DioService.instance
        .post("${DioService.authPath}/logout", data: body);
    return response;
  }
}
