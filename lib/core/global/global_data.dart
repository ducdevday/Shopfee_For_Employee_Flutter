import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

class GlobalData{
  static final ins = GlobalData._();
  GlobalData._();

  String? employeeId;
  EmployeeEntity? employeeEntity;
  String? accessToken;
  String? refreshToken;

}