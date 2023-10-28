import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/login_entity.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/employee_login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, EmployeeLoginEntity>> login(LoginEntity loginEntity);
}