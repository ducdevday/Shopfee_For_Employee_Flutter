
import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<EmployeeEntity> getEmployee(String employeeId);
  Future<void> logout();
}
