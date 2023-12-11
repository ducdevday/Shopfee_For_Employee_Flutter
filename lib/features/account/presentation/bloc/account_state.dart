part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoaded extends AccountState {
  final EmployeeEntity employeeEntity;

  const AccountLoaded({
    required this.employeeEntity,
  });

  @override
  List<Object> get props => [employeeEntity];
}

class AccountFinished extends AccountState {
  @override
  List<Object> get props => [];
}

