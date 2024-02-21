import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';


abstract class ShippingOrderRepository {
  Future<List<ShippingOrderEntity>> getOrderListByStatus(OrderType type, OrderStatus status, int page, int size);
}