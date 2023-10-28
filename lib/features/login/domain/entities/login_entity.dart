import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String account;
  final String password;

  const LoginEntity({
    required this.account,
    required this.password,
  });

  @override
  List<Object> get props => [account, password];
}
