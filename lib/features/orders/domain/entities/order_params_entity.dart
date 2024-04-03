import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';

class OrderParamsEntity{
  final OrderType orderType;
  final OrderStatus orderStatus;
  final int page;
  final int size;

  const OrderParamsEntity({
    required this.orderType,
    required this.orderStatus,
    required this.page,
    required this.size,
  });
}