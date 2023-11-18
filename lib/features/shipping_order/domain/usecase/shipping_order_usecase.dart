
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/repositories/shipping_order_repository.dart';

abstract class ShippingOrderUseCase{
  Future<Either<Failure, List<ShippingOrderEntity>>> getOrderListByStatus(OrderType type, OrderStatus status, int page, int size);
}

class ShippingOrderUseCaseImpl extends ShippingOrderUseCase{
  final ShippingOrderRepository _shippingOrderRepository;

  ShippingOrderUseCaseImpl(this._shippingOrderRepository);

  @override
  Future<Either<Failure, List<ShippingOrderEntity>>> getOrderListByStatus(OrderType type, OrderStatus status, int page, int size) async{
      return await _shippingOrderRepository.getOrderListByStatus(type, status, page, size);
  }
}