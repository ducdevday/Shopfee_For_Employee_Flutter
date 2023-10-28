import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, EmployeeEntity>> getEmployee(String employeeId);

  void saveEmployee(EmployeeEntity employeeEntity);
}