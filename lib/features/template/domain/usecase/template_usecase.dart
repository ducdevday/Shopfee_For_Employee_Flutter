
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/template/domain/entities/template_entity.dart';
import 'package:shopfeeforemployee/features/template/domain/repositories/template_repository.dart';

abstract class TemplateUseCase{
  Future<Either<Failure, TemplateEntity>> doSomething(String id);
}

class TemplateUseCaseImpl extends TemplateUseCase{
  final TemplateRepository _templateRepository;

  TemplateUseCaseImpl(this._templateRepository);

  @override
  Future<Either<Failure, TemplateEntity>> doSomething(String id) async{
    return await _templateRepository.getTemplate(id);
  }

}