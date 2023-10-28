
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/employee_login_entity.dart';

part 'employee_login_model.g.dart';

@JsonSerializable()
class EmployeeLoginModel extends EmployeeLoginEntity{
  const EmployeeLoginModel({userId, accessToken, refreshToken}) : super(userId: userId, accessToken: accessToken, refreshToken: refreshToken);
  factory EmployeeLoginModel.fromJson(Map<String, dynamic> json) {
    return _$EmployeeLoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmployeeLoginModelToJson(this);
  }
}