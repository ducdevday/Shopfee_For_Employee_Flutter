import 'package:equatable/equatable.dart';

class EmployeeLoginEntity extends Equatable{
  final String employeeId;
  final String accessToken;
  final String refreshToken;

  const EmployeeLoginEntity({required this.employeeId,required this.accessToken,required this.refreshToken});

  @override
  List<Object> get props => [employeeId, accessToken, refreshToken];
}