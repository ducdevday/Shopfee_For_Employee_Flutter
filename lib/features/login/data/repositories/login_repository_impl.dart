import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/my_token.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/login/data/datasources/login_service.dart';
import 'package:shopfeeforemployee/features/login/data/models/login_model.dart';
import 'package:shopfeeforemployee/features/login/data/models/employee_login_model.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/login_entity.dart';
import 'package:shopfeeforemployee/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService _loginService;

  LoginRepositoryImpl(this._loginService);

  @override
  Future<MyToken> login(LoginEntity loginEntity) async {
    try {
      final response =
          await _loginService.login(LoginModel.fromEntity(loginEntity));
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );

      final token = MyToken.fromJson(result.data!);
      return token;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          throw ServerFailure(message: "Account has been locked");
        } else if (e.response?.statusCode == 401) {
          throw ServerFailure(message: "Password is incorrect");
        } else if (e.response?.statusCode == 404) {
          throw ServerFailure(message: "Account doesn't exist");
        }
      }
      rethrow;
    }
  }
}
