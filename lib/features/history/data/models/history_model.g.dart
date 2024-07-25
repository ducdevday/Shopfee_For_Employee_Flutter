// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      id: json['id'] as String,
      total: (json['total'] as num).toDouble(),
      customerName: json['customerName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      productName: json['productName'] as String,
      productQuantity: (json['productQuantity'] as num).toInt(),
      thumbnailUrl: json['productThumbnailUrl'] as String,
      orderType: $enumDecode(_$OrderTypeEnumMap, json['orderType']),
      statusLastEvent:
          $enumDecode(_$OrderStatusEnumMap, json['statusLastEvent']),
      timeLastEvent: DateTime.parse(json['timeLastEvent'] as String),
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'customerName': instance.customerName,
      'phoneNumber': instance.phoneNumber,
      'productName': instance.productName,
      'productQuantity': instance.productQuantity,
      'productThumbnailUrl': instance.thumbnailUrl,
      'orderType': instance.orderType,
      'statusLastEvent': _$OrderStatusEnumMap[instance.statusLastEvent]!,
      'timeLastEvent': instance.timeLastEvent.toIso8601String(),
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};

const _$OrderStatusEnumMap = {
  OrderStatus.CREATED: 'CREATED',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.CANCELLATION_REQUEST: 'CANCELLATION_REQUEST',
  OrderStatus.CANCELLATION_REQUEST_REFUSED: 'CANCELLATION_REQUEST_REFUSED',
  OrderStatus.CANCELLATION_REQUEST_ACCEPTED: 'CANCELLATION_REQUEST_ACCEPTED',
  OrderStatus.PENDING_PICK_UP: 'PENDING_PICK_UP',
  OrderStatus.IN_DELIVERY: 'IN_DELIVERY',
  OrderStatus.NOT_RECEIVED: 'NOT_RECEIVED',
  OrderStatus.CANCELED: 'CANCELED',
  OrderStatus.SUCCEED: 'SUCCEED',
};
