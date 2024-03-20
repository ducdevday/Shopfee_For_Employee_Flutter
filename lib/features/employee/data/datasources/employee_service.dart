import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';

class EmployeeService {
  Future<Response> getEmployee(String employeeId) async {
    final response =
        DioService.instance.get("${DioService.employeePath}/$employeeId");
    return response;
  }

  Future<Response> logout() async {
    final response =
    await DioService.instance.get("${DioService.authPath}/logout");
    return response;
  }
}
