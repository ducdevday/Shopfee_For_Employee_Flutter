
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/employee_login_entity.dart';

part 'employee_login_model.g.dart';

@JsonSerializable()
class EmployeeLoginModel{
  final String employeeId;
  final String accessToken;
  final String branchId;

  const EmployeeLoginModel({
    required this.employeeId,
    required this.accessToken,
    required this.branchId
  });

  factory EmployeeLoginModel.fromJson(Map<String, dynamic> json) {
    return _$EmployeeLoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmployeeLoginModelToJson(this);
  }
}