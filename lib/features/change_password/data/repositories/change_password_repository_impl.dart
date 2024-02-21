import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/features/change_password/data/datasources/change_password_service.dart';
import 'package:shopfeeforemployee/features/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordService _changePasswordService;

  ChangePasswordRepositoryImpl(this._changePasswordService);

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final response = await _changePasswordService.changePassword(
          SharedService.getEmployeeId()!, oldPassword, newPassword);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ServerFailure(message: "Current Password Incorrect");
        }
      }
      rethrow;
    }
  }
}
