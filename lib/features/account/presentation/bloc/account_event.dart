part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class LoadAccount extends AccountEvent {
  @override
  List<Object> get props => [];
}

class LogoutAccount extends AccountEvent {
  @override
  List<Object> get props => [];
}
