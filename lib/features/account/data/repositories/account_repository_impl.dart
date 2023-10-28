import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/features/account/domain/repositories/account_repository.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl();

  @override
  EmployeeEntity getEmployee() {
    return GlobalData.ins.employeeEntity!;
  }

  @override
  void logout() {
    SharedService.removeEmployeeId();
    SharedService.removeAccessToken();
    SharedService.removeRefreshToken();
    GlobalData.ins.employeeEntity = null;
    GlobalData.ins.employeeId = null;
    GlobalData.ins.accessToken = null;
    GlobalData.ins.refreshToken = null;
  }
}
