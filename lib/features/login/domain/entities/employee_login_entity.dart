import 'package:equatable/equatable.dart';

class EmployeeLoginEntity extends Equatable{
  final String employeeId;
  final String accessToken;
  final String branchId;

  const EmployeeLoginEntity({required this.employeeId,required this.accessToken, required this.branchId});

  @override
  List<Object> get props => [employeeId, accessToken, branchId];
}