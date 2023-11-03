import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<HistoryEntity>>> getHistoryByStatus(int page, int size, OrderStatus status);
}