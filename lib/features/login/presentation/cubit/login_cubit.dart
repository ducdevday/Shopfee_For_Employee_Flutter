part of login;


class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitial());

  bool checkValidField({required String account, required String password}) {
    if (ValidateFieldUtil.validateAccount(account) &&
        ValidateFieldUtil.validatePassword(password)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> doLogin(String account, String password) async {
    if (checkValidField(account: account, password: password) == false) return;
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final response = await _loginUseCase
          .login(LoginEntity(account: account, password: password));
      SharedService.setToken(
          response.employeeId, response.accessToken, response.refreshToken);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Login Success");
      emit(LoginSuccess());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
