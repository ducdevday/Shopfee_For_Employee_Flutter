import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/features/employee/data/models/employee_model.dart';

class PersonalInformationService {
  Future<Response> updateEmployee(
      String employeeId, EmployeeModel employee) async {
    Map<String, dynamic> body = employee.toJson();
    final response = await DioService.instance
        .patch("${DioService.employeePath}/$employeeId/profile", data: body);
    return response;
  }
}
