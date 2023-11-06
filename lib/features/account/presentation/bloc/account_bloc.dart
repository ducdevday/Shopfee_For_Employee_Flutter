import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfeeforemployee/features/account/domain/usecase/account_usecase.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountUseCase _accountUseCase;
  AccountBloc(this._accountUseCase) : super(AccountInitial()) {
    on<LoadAccount>(_onLoadAccount);
    on<LogoutAccount>(_onLogoutAccount);
  }

  FutureOr<void> _onLoadAccount(LoadAccount event, Emitter<AccountState> emit) async{
    final employeeEntity = _accountUseCase.getEmployee();
    emit(AccountLoaded(employeeEntity: employeeEntity));
  }

  FutureOr<void> _onLogoutAccount(LogoutAccount event, Emitter<AccountState> emit) async {
    _accountUseCase.logout();
    emit(AccountFinished());
  }
}
