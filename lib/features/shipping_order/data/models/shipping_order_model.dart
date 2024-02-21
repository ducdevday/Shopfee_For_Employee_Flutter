import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';

part 'shipping_order_model.g.dart';

@JsonSerializable()
class ShippingOrderModel {
  final String id;
  final num total;
  final String customerName;
  final String phoneNumber;
  final String productName;
  final int productQuantity;
  final String thumbnailUrl;
  final OrderStatus statusLastEvent;
  final DateTime timeLastEvent;

  const ShippingOrderModel({
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

  factory ShippingOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingOrderModelToJson(this);
}
