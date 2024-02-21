import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/personal_information/domain/repositories/personnal_information_repository.dart';

abstract class PersonalInformationUseCase{
  Future<void> updateEmployee(String employeeId, EmployeeEntity employeeEntity);
}

class PersonalInformationUseCaseImpl extends PersonalInformationUseCase{
  final PersonalInformationRepository _personalInformationRepository;

  PersonalInformationUseCaseImpl(this._personalInformationRepository);

  @override
  Future<void> updateEmployee(String employeeId, EmployeeEntity employeeEntity) async{
    return await _personalInformationRepository.updateEmployee(employeeId, employeeEntity);
  }
}