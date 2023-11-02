import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/login_entity.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/employee_login_entity.dart';
import 'package:shopfeeforemployee/features/login/domain/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitial());

  Future<void> initField() async {
    emit(LoginLoaded());
  }

  Future<void> enterAccount(String account) async {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      emit(currentState.copyWith(account: account));
    }
  }

  Future<void> enterPassword(String password) async {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      emit(currentState.copyWith(password: password));
    }
  }

  Future<void> doLogin() async {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final res = await _loginUseCase.login(LoginEntity(
          account: currentState.account, password: currentState.password));
      EasyLoading.dismiss();

      res.fold((failure) => ExceptionUtil.handle(failure), (employeeLoginEntity) {
        saveEmployee(employeeLoginEntity);
        emit(LoginFinished());
      });
    }
  }

  void saveEmployee(EmployeeLoginEntity employeeLoginEntity) {
    SharedService.setEmployeeId(employeeLoginEntity.employeeId);
    SharedService.setAccessToken(employeeLoginEntity.accessToken);
    SharedService.setRefreshToken(employeeLoginEntity.refreshToken);
    GlobalData.ins.employeeId = employeeLoginEntity.employeeId;
    GlobalData.ins.accessToken = employeeLoginEntity.accessToken;
    GlobalData.ins.refreshToken = employeeLoginEntity.refreshToken;
  }
}
