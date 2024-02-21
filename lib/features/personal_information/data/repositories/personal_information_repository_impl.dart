import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/personal_information/data/datasources/personal_information_service.dart';
import 'package:shopfeeforemployee/features/personal_information/domain/repositories/personnal_information_repository.dart';

class PersonalInformationRepositoryImpl
    implements PersonalInformationRepository {
  final PersonalInformationService _personalInformationService;

  PersonalInformationRepositoryImpl(this._personalInformationService);

  @override
  Future<void> updateEmployee(
      String employeeId, EmployeeEntity employeeEntity) async {
    final response = await _personalInformationService.updateEmployee(
        employeeId, employeeEntity);
  }
}
