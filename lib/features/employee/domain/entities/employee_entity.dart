import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:shopfeeforemployee/core/common/models/gender.dart';

class EmployeeEntity extends Equatable {
  final String? username;
  final String? firstName;
  final String? lastName;
  final Gender? gender;
  final DateTime? birthDate;

  String get fullName => "$firstName $lastName";

  const EmployeeEntity(
      {required this.username,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.birthDate});

  @override
  List<Object?> get props => [
        username,
        firstName,
        lastName,
        gender,
        birthDate,
      ];

  EmployeeEntity copyWith({
    String? username,
    String? firstName,
    String? lastName,
    Gender? gender,
    DateTime? birthDate,
  }) {
    return EmployeeEntity(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
