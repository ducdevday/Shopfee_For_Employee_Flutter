
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';
import 'package:shopfeeforemployee/features/history/domain/repositories/history_repository.dart';

abstract class HistoryUseCase{
  Future<Either<Failure, List<HistoryEntity>>> getHistoryByStatus(int page, int size, OrderStatus status);
}

class HistoryUseCaseImpl extends HistoryUseCase{
  final HistoryRepository _historyRepository;

  HistoryUseCaseImpl(this._historyRepository);

  @override
  Future<Either<Failure, List<HistoryEntity>>> getHistoryByStatus(int page, int size, OrderStatus status) async {
    return await _historyRepository.getHistoryByStatus(page, size, status);
  }
}