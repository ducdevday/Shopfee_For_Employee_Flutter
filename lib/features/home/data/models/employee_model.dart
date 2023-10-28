import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/gender.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel extends EmployeeEntity {
  EmployeeModel(
      {required super.username,
      required super.firstName,
      required super.lastName,
      required super.gender,
      required super.birthDate});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  factory EmployeeModel.fromEntity(EmployeeEntity employeeEntity) {
    return EmployeeModel(
        username: employeeEntity.username,
        firstName: employeeEntity.firstName,
        lastName: employeeEntity.lastName,
        gender: employeeEntity.gender,
        birthDate: employeeEntity.birthDate);
  }

  EmployeeEntity toEntity() => EmployeeEntity(username: username, firstName: firstName, lastName: lastName, gender: gender, birthDate: birthDate);

}
