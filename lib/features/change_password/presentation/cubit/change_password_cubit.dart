part of change_password;

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
      : super(ChangePasswordInitial());

  bool checkValidField({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (ValidateFieldUtil.validatePassword(currentPassword) &&
        ValidateFieldUtil.validatePassword(newPassword) &&
        ValidateFieldUtil.validatePassword(confirmPassword) &&
        newPassword == confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    if (checkValidField(
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword) ==
        false) return;
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await _changePasswordUseCase.changePassword(
          currentPassword, newPassword);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Change Password Successfully",
          duration: Duration(milliseconds: 1000));
      emit(ChangePasswordSuccess());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
