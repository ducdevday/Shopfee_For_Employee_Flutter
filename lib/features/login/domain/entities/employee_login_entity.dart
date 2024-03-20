import 'package:equatable/equatable.dart';

class EmployeeLoginEntity extends Equatable{
  final String employeeId;
  final String accessToken;

  const EmployeeLoginEntity({required this.employeeId,required this.accessToken});

  @override
  List<Object> get props => [employeeId, accessToken,];
}