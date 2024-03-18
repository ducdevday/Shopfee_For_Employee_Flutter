import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';

class EmployeeService {
  Future<Response> getEmployee(String employeeId) async {
    final response =
        DioService.instance.get("${DioService.employeePath}/$employeeId");
    return response;
  }
}
