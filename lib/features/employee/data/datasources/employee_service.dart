
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';

class EmployeeService extends BaseService{
  Future<Response> getEmployee(String employeeId) async{
    final response = dio.get("${BaseService.employeePath}/$employeeId");
    return response;
  }
}