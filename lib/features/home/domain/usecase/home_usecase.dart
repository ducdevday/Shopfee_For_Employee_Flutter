import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/home/domain/repositories/home_repository.dart';

abstract class HomeUseCase {
  Future<Either<Failure, EmployeeEntity>> getEmployee(String employeeId);
  void saveEmployee (EmployeeEntity employeeEntity);

}

class HomeUseCaseImpl extends HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCaseImpl(this._homeRepository);

  @override
  Future<Either<Failure, EmployeeEntity>> getEmployee(String employeeId) async {
    return await _homeRepository.getEmployee(employeeId);
  }

  @override
  void saveEmployee(EmployeeEntity employeeEntity) {
    return _homeRepository.saveEmployee(employeeEntity);
  }
}
