import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';

abstract class ChangePasswordRepository {
  Future<void> changePassword(String oldPassword, String newPassword);
}