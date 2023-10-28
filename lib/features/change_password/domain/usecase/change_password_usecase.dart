
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/change_password/domain/repositories/change_password_repository.dart';

abstract class ChangePasswordUseCase{
  Future<Either<Failure, NoResponse>> changePassword(String oldPassword, String newPassword);
}

class ChangePasswordUseCaseImpl extends ChangePasswordUseCase{
  final ChangePasswordRepository _changePasswordRepository;

  ChangePasswordUseCaseImpl(this._changePasswordRepository);

  @override
  Future<Either<Failure, NoResponse>> changePassword(String oldPassword, String newPassword) async{
      return await _changePasswordRepository.changePassword(oldPassword, newPassword);
  }
}