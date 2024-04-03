import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/enum/employee_status.dart';
import 'package:shopfeeforemployee/core/common/models/gender.dart';
import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final Gender? gender;
  final DateTime? birthDate;
  final String? email;
  final String? phoneNumber;
  final EmployeeStatus? status;
  final String? branchName;

  const EmployeeModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthDate,
    this.email,
    this.phoneNumber,
    this.status,
    this.branchName,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  factory EmployeeModel.fromEntity(EmployeeEntity entity) {
    return EmployeeModel(
      id: entity.id,
      username: entity.username,
      firstName: entity.firstName,
      lastName: entity.lastName,
      gender: entity.gender,
      birthDate: entity.birthDate,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      branchName: entity.branchName,
    );
  }

  EmployeeEntity toEntity() => EmployeeEntity(
        username: username,
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        birthDate: birthDate,
        email: email,
        phoneNumber: phoneNumber,
        status: status,
        branchName: branchName,
      );
}
