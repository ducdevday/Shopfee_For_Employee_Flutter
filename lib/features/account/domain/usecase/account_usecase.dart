import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/features/account/domain/repositories/account_repository.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';

abstract class AccountUseCase {
  EmployeeEntity getEmployee();
  void logout();
}

class AccountUseCaseImpl extends AccountUseCase {
  final AccountRepository _accountRepository;
  AccountUseCaseImpl(this._accountRepository);

  @override
  EmployeeEntity getEmployee() {
    return _accountRepository.getEmployee();
  }

  @override
  void logout() {
    _accountRepository.logout();
  }
}
