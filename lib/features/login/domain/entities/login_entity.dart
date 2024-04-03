import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String account;
  final String password;
  final String fcmTokenId;
  const LoginEntity({
    required this.account,
    required this.password,
    required this.fcmTokenId
  });

  @override
  List<Object> get props => [account, password, fcmTokenId];
}
