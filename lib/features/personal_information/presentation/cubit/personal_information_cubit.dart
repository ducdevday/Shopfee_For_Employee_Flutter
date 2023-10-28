import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/common/models/gender.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/personal_information/domain/usecase/personnal_information_usecase.dart';

part 'personal_information_state.dart';

class PersonalInformationCubit extends Cubit<PersonalInformationState> {
  final PersonalInformationUseCase _personalInformationUseCase;

  PersonalInformationCubit(this._personalInformationUseCase)
      : super(PersonalInformationInitial());

  Future<void> initField() async {
    EasyLoading.show();
    EmployeeEntity employeeEntity = _personalInformationUseCase.getEmployee();
    EasyLoading.dismiss();
    emit(PersonalInformationLoaded(employee: employeeEntity));
  }

  Future<void> updateFirstName(String firstName) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          employee: currentState.employee.copyWith(firstName: firstName)));
    }
  }

  Future<void> updateLastName(String lastName) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          employee: currentState.employee.copyWith(lastName: lastName)));
    }
  }

  // Future<void> updatePhoneNumber(String phoneNumber) async {
  //   if (state is PersonalInformationLoaded) {
  //     final currentState = state as PersonalInformationLoaded;
  //     emit(PersonalInformationLoaded(
  //         employeeEntity: currentState.employeeEntity.copyWith(phoneNumber: phoneNumber)));
  //   }
  // }

  Future<void> updateBirthday(DateTime birthdate) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          employee: currentState.employee.copyWith(birthDate: birthdate)));
    }
  }

  Future<void> updateGender(Gender gender) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          employee: currentState.employee.copyWith(gender: gender)));
    }
  }

  Future<void> updateEmployee() async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await _personalInformationUseCase
          .updateEmployee(currentState.employee);
      EasyLoading.dismiss();
      response.fold((failure) => ExceptionUtil.handle(failure), (_) {
        EasyLoading.showInfo("Update Information Successfully",
            duration: Duration(milliseconds: 2000));
        Future.delayed(Duration(milliseconds: 2000), () {
          emit(PersonalInformationFinished());
        });

      });
    }
  }
}
