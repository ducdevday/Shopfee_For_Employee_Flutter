import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/features/employee/data/datasources/employee_service.dart';
import 'package:shopfeeforemployee/features/employee/data/models/employee_model.dart';
import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/employee/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeService _employeeService;

  EmployeeRepositoryImpl(this._employeeService);

  @override
  Future<EmployeeEntity> getEmployee(String employeeId) async {
    final response = await _employeeService.getEmployee(employeeId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );

    final employeeModel = EmployeeModel.fromJson(result.data!);
    final employeeEntity = employeeModel.toEntity();
    return employeeEntity;
  }

  @override
  Future<void> logout(String fcmTokenId) async {
    final response = await _employeeService.logout(fcmTokenId);
  }
}
