import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

abstract class AccountRepository{
  EmployeeEntity getEmployee();
  void logout();
}