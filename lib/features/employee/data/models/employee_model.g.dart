// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      id: json['id'] as String?,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      status: $enumDecodeNullable(_$EmployeeStatusEnumMap, json['status']),
      branchName: json['branchName'] as String?,
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'branchName': instance.branchName,
    };

const _$GenderEnumMap = {
  Gender.FEMALE: 'FEMALE',
  Gender.MALE: 'MALE',
  Gender.OTHER: 'OTHER',
};

const _$EmployeeStatusEnumMap = {
  EmployeeStatus.ACTIVE: 'ACTIVE',
  EmployeeStatus.INACTIVE: 'INACTIVE',
};
