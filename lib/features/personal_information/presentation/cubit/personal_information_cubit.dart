part of personal_information;

class PersonalInformationCubit extends Cubit<PersonalInformationState> {
  final PersonalInformationUseCase _personalInformationUseCase;

  PersonalInformationCubit(this._personalInformationUseCase)
      : super(PersonalInformationInitial());

  void checkValidField({
    required String firstName,
    required String lastName,
  }) {
    if (ValidateFieldUtil.validateName(firstName) &&
        ValidateFieldUtil.validateName(lastName)) {
      emit(const PersonalInformationReady());
    } else {
      emit(PersonalInformationInitial());
    }
  }

  Future<void> updateEmployee(EmployeeEntity employeeEntity) async {
    if (state is PersonalInformationReady) {
      try {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response = await _personalInformationUseCase.updateEmployee(
            SharedService.getEmployeeId()!, employeeEntity);
        EasyLoading.dismiss();
        EasyLoading.showInfo("Update Information Successfully",
            duration: const Duration(milliseconds: 2000));
        emit(PersonalInformationFinished());
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }
}
