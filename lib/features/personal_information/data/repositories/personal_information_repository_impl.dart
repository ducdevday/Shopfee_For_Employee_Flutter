import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/personal_information/data/datasources/personal_information_service.dart';
import 'package:shopfeeforemployee/features/personal_information/domain/repositories/personnal_information_repository.dart';

class PersonalInformationRepositoryImpl
    implements PersonalInformationRepository {
  final PersonalInformationService _personalInformationService;

  PersonalInformationRepositoryImpl(this._personalInformationService);

  @override
  EmployeeEntity getEmployee() {
    return GlobalData.ins.employeeEntity!;
  }

  @override
  Future<Either<Failure, NoResponse>> updateEmployee(
      EmployeeEntity employeeEntity) async {
    try {
      final response = await _personalInformationService.updateEmployee(
          GlobalData.ins.employeeId!, employeeEntity);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
      );
      if (result.success) {
        GlobalData.ins.employeeEntity = employeeEntity;
        return Right(NoResponse());
      }
      return Left(UnknownFailure());
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
}
