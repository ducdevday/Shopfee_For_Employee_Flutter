import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/features/employee/data/models/employee_model.dart';
import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';

class PersonalInformationService {
  Future<Response> updateEmployee(
      String employeeId, EmployeeEntity employeeEntity) async {
    EmployeeModel employeeModel = EmployeeModel.fromEntity(employeeEntity);
    Map<String, dynamic> body = employeeModel.toJson();
    final response = await DioService.instance
        .put("${DioService.employeePath}/$employeeId", data: body);
    return response;
  }
}
