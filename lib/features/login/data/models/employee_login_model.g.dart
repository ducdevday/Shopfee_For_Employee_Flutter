// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeLoginModel _$EmployeeLoginModelFromJson(Map<String, dynamic> json) =>
    EmployeeLoginModel(
      employeeId: json['employeeId'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );

Map<String, dynamic> _$EmployeeLoginModelToJson(EmployeeLoginModel instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
