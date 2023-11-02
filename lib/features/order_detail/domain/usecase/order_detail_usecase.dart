
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/repositories/order_detail_repository.dart';

abstract class OrderDetailUseCase{
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(String orderId);
  Future<Either<Failure, List<EventLogEntity>>> getEventLogs(String orderId);
  Future<Either<Failure, NoResponse>> addEventLog(String orderId, EventLogEntity eventLog);
}

class OrderDetailUseCaseImpl extends OrderDetailUseCase{
  final OrderDetailRepository _orderDetailRepository;

  OrderDetailUseCaseImpl(this._orderDetailRepository);

  @override
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(String orderId) async{
    return await _orderDetailRepository.getOrderDetail(orderId);
  }

  @override
  Future<Either<Failure, List<EventLogEntity>>> getEventLogs(String orderId) async{
    return await _orderDetailRepository.getEventLogs(orderId);
  }

  @override
  Future<Either<Failure, NoResponse>> addEventLog(String orderId, EventLogEntity eventLog) async{
    return await _orderDetailRepository.addEventLog(orderId, eventLog);

  }
}