import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/template/data/datasources/template_service.dart';
import 'package:shopfeeforemployee/features/template/data/models/template_model.dart';
import 'package:shopfeeforemployee/features/template/domain/repositories/template_repository.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  final TemplateService _templateService;

  TemplateRepositoryImpl(this._templateService);

  @override
  Future<Either<Failure, TemplateModel>> getTemplate(String id) async {
    try {
      final response = await _templateService.doSomeThing(id);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
      final template = TemplateModel.fromJson(json: result.data!);

      return Right(template);
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
