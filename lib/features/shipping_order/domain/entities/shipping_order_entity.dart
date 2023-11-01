import 'package:shopfeeforemployee/core/common/models/order_status.dart';

class ShippingOrderEntity {
  final String id;
  final double total;
  final String customerName;
  final String phoneNumber;
  final String productName;
  final int productQuantity;
  final String thumbnailUrl;
  final OrderStatus statusLastEvent;
  final DateTime timeLastEvent;

  const ShippingOrderEntity({
    required this.id,
    required this.total,
    required this.customerName,
    required this.phoneNumber,
    required this.productName,
    required this.productQuantity,
    required this.thumbnailUrl,
    required this.statusLastEvent,
    required this.timeLastEvent,
  });
}