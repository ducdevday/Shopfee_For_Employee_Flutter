// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeLoginModel _$EmployeeLoginModelFromJson(Map<String, dynamic> json) =>
    EmployeeLoginModel(
      employeeId: json['employeeId'] as String,
      accessToken: json['accessToken'] as String,
      branchId: json['branchId'] as String,
    );

Map<String, dynamic> _$EmployeeLoginModelToJson(EmployeeLoginModel instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'accessToken': instance.accessToken,
      'branchId': instance.branchId,
    };
