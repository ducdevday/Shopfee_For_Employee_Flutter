import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/features/home/data/datasources/home_service.dart';
import 'package:shopfeeforemployee/features/home/data/models/employee_model.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeService _homeService;

  HomeRepositoryImpl(this._homeService);

  @override
  Future<Either<Failure, EmployeeModel>> getEmployee(String employeeId) async {
    try {
      final response = await _homeService.getEmployee(employeeId);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );

      final employeeModel = EmployeeModel.fromJson(result.data!);
      return Right(employeeModel);
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          return Left(NetworkFailure());
        }
        return Left(UnknownFailure());
      }
      return Left(UnknownFailure());
    }
  }

  @override
  void saveEmployee(EmployeeEntity employeeEntity) {
    GlobalData.ins.employeeEntity = employeeEntity;
  }
}
