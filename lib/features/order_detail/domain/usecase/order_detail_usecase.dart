
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/repositories/order_detail_repository.dart';

abstract class OrderDetailUseCase{
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(String orderId);
}

class OrderDetailUseCaseImpl extends OrderDetailUseCase{
  final OrderDetailRepository _orderDetailRepository;

  OrderDetailUseCaseImpl(this._orderDetailRepository);

  @override
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(String orderId) async{
    return await _orderDetailRepository.getOrderDetail(orderId);
  }
}