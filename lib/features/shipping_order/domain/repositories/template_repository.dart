import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/features/template/domain/entities/template_entity.dart';

abstract class TemplateRepository {
  Future<Either<Failure, TemplateEntity>> getTemplate(String id);
}