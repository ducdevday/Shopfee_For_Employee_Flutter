import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';

part 'shipping_order_model.g.dart';

@JsonSerializable()
class ShippingOrderModel extends ShippingOrderEntity {
  const ShippingOrderModel({
    required super.id,
    required super.total,
    required super.customerName,
    required super.phoneNumber,
    super.productName = "Product Temp",
    required super.productQuantity,
    required super.thumbnailUrl,
    required super.statusLastEvent,
    required super.timeLastEvent,
  });
  factory ShippingOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingOrderModelToJson(this);


}
