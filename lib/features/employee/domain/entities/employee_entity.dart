import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:shopfeeforemployee/core/common/enum/employee_status.dart';
import 'package:shopfeeforemployee/core/common/models/gender.dart';

class EmployeeEntity {
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

  String get fullName => "$firstName $lastName";

  const EmployeeEntity({
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
}
