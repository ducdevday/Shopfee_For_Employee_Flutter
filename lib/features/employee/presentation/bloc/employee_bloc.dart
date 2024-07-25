part of employee;

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeUseCase _employeeUseCase;

  EmployeeBloc(this._employeeUseCase) : super(EmployeeInitial()) {
    on<EmployeeLoadInformation>(_onEmployeeLoadInformation);
    on<EmployeeLogout>(_onEmployeeLogout);
  }

  FutureOr<void> _onEmployeeLoadInformation(
      EmployeeLoadInformation event, Emitter<EmployeeState> emit) async {
    if (SharedService.getEmployeeId() == null) {
      emit(EmployeeInitial());
      return;
    }
    try {
      emit(EmployeeLoadInProcess());
      final EmployeeEntity employee =
          await _employeeUseCase.getEmployee(SharedService.getEmployeeId()!);
      emit(EmployeeLoadSuccess(employee: employee));
    } catch (e) {
      emit(EmployeeLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onEmployeeLogout(
      EmployeeLogout event, Emitter<EmployeeState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _employeeUseCase.logout(SharedService.getFCMTokenId()!);
      SharedService.clearToken();
      emit(EmployeeInitial());
      EasyLoading.dismiss();
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
