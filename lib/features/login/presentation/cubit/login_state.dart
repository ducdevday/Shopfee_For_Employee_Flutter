part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  final String account;
  final String password;

  const LoginLoaded({this.account = "", this.password = ""});

  bool isValid() {
    if (account.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  List<Object> get props => [account, password];

  LoginLoaded copyWith({
    String? account,
    String? password,
  }) {
    return LoginLoaded(
      account: account ?? this.account,
      password: password ?? this.password,
    );
  }
}

class LoginFinished extends LoginState {
  @override
  List<Object> get props => [];
}