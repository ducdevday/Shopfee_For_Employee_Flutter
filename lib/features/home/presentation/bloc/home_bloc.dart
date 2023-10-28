import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/home/domain/usecase/home_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;

  HomeBloc(this._homeUseCase) : super(HomeInitial()) {
    on<LoadHome>(_onLoadHome);
  }

  FutureOr<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    EasyLoading.show();
    final res = await _homeUseCase.getEmployee(GlobalData.ins.employeeId!);
    EasyLoading.dismiss();

    res.fold((failure) => ExceptionUtil.handle(failure),
        (employeeEntity) async {
      _homeUseCase.saveEmployee(employeeEntity);
      emit(HomeLoaded(employeeEntity: employeeEntity));
    });
  }
}
