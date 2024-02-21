import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/employee/domain/repositories/employee_repository.dart';

abstract class EmployeeUseCase {
  Future<EmployeeEntity> getEmployee(String employeeId);

}

class EmployeeUseCaseImpl extends EmployeeUseCase {
  final EmployeeRepository _employeeRepository;

  EmployeeUseCaseImpl(this._employeeRepository);

  @override
  Future<EmployeeEntity> getEmployee(String employeeId) async {
    return await _employeeRepository.getEmployee(employeeId);
  }
}
