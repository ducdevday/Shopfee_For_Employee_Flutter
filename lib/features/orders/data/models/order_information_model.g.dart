// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderInformationModel _$OrderInformationModelFromJson(
        Map<String, dynamic> json) =>
    OrderInformationModel(
      id: json['id'] as String,
      total: json['total'] as num,
      customerName: json['customerName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      productName: json['productName'] as String,
      productQuantity: (json['productQuantity'] as num).toInt(),
      thumbnailUrl: json['productThumbnailUrl'] as String,
      statusLastEvent:
          $enumDecode(_$OrderStatusEnumMap, json['statusLastEvent']),
      timeLastEvent: DateTime.parse(json['timeLastEvent'] as String),
      receiveTime: json['receiveTime'] == null
          ? null
          : DateTime.parse(json['receiveTime'] as String),
    );

Map<String, dynamic> _$OrderInformationModelToJson(
        OrderInformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'customerName': instance.customerName,
      'phoneNumber': instance.phoneNumber,
      'productName': instance.productName,
      'productQuantity': instance.productQuantity,
      'productThumbnailUrl': instance.thumbnailUrl,
      'statusLastEvent': _$OrderStatusEnumMap[instance.statusLastEvent]!,
      'timeLastEvent': instance.timeLastEvent.toIso8601String(),
      'receiveTime': instance.receiveTime?.toIso8601String(),
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
