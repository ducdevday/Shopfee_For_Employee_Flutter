
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/my_token.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/login_entity.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/employee_login_entity.dart';
import 'package:shopfeeforemployee/features/login/domain/repositories/login_repository.dart';

abstract class LoginUseCase{
  Future<MyToken> login(LoginEntity loginEntity);
}

class LoginUseCaseImpl extends LoginUseCase{
  final LoginRepository _loginRepository;

  LoginUseCaseImpl(this._loginRepository);

  @override
  Future<MyToken> login(LoginEntity loginEntity) async{
      return await _loginRepository.login(loginEntity);
  }

}