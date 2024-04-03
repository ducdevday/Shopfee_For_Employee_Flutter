import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';

abstract class PersonalInformationRepository {
  Future<void> updateEmployee(String employeeId, EmployeeEntity employeeEntity);
}
