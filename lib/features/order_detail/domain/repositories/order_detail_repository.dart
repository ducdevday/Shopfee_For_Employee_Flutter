import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';

abstract class OrderDetailRepository {
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(String orderId);
  Future<Either<Failure, List<EventLogEntity>>> getEventLogs(String orderId);
  Future<Either<Failure, NoResponse>> addEventLog(String orderId, EventLogEntity eventLog);

}