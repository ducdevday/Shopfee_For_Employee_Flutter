import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';


abstract class ShippingOrderRepository {
  Future<Either<Failure, List<ShippingOrderEntity>>> getOrderListByStatus(OrderType type, OrderStatus status);
}