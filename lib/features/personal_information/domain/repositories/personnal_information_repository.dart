import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

abstract class PersonalInformationRepository {
  EmployeeEntity getEmployee();

  Future<Either<Failure, NoResponse>> updateEmployee(EmployeeEntity employeeEntity);
}
