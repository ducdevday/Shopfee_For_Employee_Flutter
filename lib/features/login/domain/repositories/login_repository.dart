import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/my_token.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/login_entity.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/employee_login_entity.dart';

abstract class LoginRepository {
  Future<MyToken> login(LoginEntity loginEntity);
}