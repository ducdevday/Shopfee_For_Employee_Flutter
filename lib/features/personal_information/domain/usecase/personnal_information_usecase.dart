import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/personal_information/domain/repositories/personnal_information_repository.dart';

abstract class PersonalInformationUseCase{
  EmployeeEntity getEmployee();
  Future<Either<Failure, NoResponse>> updateEmployee(EmployeeEntity employeeEntity);
}

class PersonalInformationUseCaseImpl extends PersonalInformationUseCase{
  final PersonalInformationRepository _personalInformationRepository;

  PersonalInformationUseCaseImpl(this._personalInformationRepository);

  @override
  EmployeeEntity getEmployee() {
    return _personalInformationRepository.getEmployee();
  }

  @override
  Future<Either<Failure, NoResponse>> updateEmployee(EmployeeEntity employeeEntity) async{
    return await _personalInformationRepository.updateEmployee(employeeEntity);
  }
}