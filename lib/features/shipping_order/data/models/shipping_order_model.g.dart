// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingOrderModel _$ShippingOrderModelFromJson(Map<String, dynamic> json) =>
    ShippingOrderModel(
      id: json['id'] as String,
      total: (json['total'] as num).toDouble(),
      customerName: json['customerName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      productName: json['productName'] as String? ?? "Product Temp",
      productQuantity: json['productQuantity'] as int,
      thumbnailUrl: json['thumbnailUrl'] as String,
      statusLastEvent:
          $enumDecode(_$OrderStatusEnumMap, json['statusLastEvent']),
      timeLastEvent: DateTime.parse(json['timeLastEvent'] as String),
    );

Map<String, dynamic> _$ShippingOrderModelToJson(ShippingOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'customerName': instance.customerName,
      'phoneNumber': instance.phoneNumber,
      'productName': instance.productName,
      'productQuantity': instance.productQuantity,
      'thumbnailUrl': instance.thumbnailUrl,
      'statusLastEvent': instance.statusLastEvent,
      'timeLastEvent': instance.timeLastEvent.toIso8601String(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.CREATED: 'CREATED',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.DELIVERING: 'DELIVERING',
  OrderStatus.SUCCEED: 'SUCCEED',
  OrderStatus.CANCELED: 'CANCELED',
};
