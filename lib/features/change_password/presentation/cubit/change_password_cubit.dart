import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/features/change_password/domain/usecase/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
      : super(ChangePasswordInitial());

  void initPassword() {
    emit(const ChangePasswordLoaded());
  }

  void enterOldPassword(String oldPassword) {
    if (state is ChangePasswordLoaded) {
      final currentState = state as ChangePasswordLoaded;
      emit(currentState.copyWith(oldPassword: oldPassword));
    }
  }

  void enterNewPassword(String newPassword) {
    if (state is ChangePasswordLoaded) {
      final currentState = state as ChangePasswordLoaded;
      emit(currentState.copyWith(newPassword: newPassword));
    }
  }

  void enterConfirmPassword(String confirmPassword) {
    if (state is ChangePasswordLoaded) {
      final currentState = state as ChangePasswordLoaded;
      emit(currentState.copyWith(confirmPassword: confirmPassword));
    }
  }

  Future<void> changePassword() async {
    if (state is ChangePasswordLoaded) {
      final currentState = state as ChangePasswordLoaded;
      if (currentState.newPassword != currentState.confirmPassword) {
        EasyLoading.showError(
            "New Password and Confirm New Password is not match");
        return;
      }
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await _changePasswordUseCase.changePassword(
          currentState.oldPassword, currentState.newPassword);
      EasyLoading.dismiss();
      response.fold((failure) => ExceptionUtil.handle(failure), (_) {
        EasyLoading.showSuccess("Change Password Successfully",
            duration: Duration(milliseconds: 1000));
        Future.delayed(Duration(milliseconds: 1000), () {
          emit(ChangePasswordFinished());
        });
      });
    }
  }
}
