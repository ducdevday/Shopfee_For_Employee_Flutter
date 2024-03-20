// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventLogModel _$EventLogModelFromJson(Map<String, dynamic> json) =>
    EventLogModel(
      orderStatus:
          $enumDecodeNullable(_$OrderStatusEnumMap, json['orderStatus']),
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      description: json['description'] as String?,
      makerByEmployee: json['makerByEmployee'] as bool?,
    );

Map<String, dynamic> _$EventLogModelToJson(EventLogModel instance) =>
    <String, dynamic>{
      'orderStatus': instance.orderStatus,
      'time': instance.time?.toIso8601String(),
      'description': instance.description,
      'makerByEmployee': instance.makerByEmployee,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.CREATED: 'CREATED',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.CANCELLATION_REQUEST: 'CANCELLATION_REQUEST',
  OrderStatus.CANCELLATION_REQUEST_REFUSED: 'CANCELLATION_REQUEST_REFUSED',
  OrderStatus.CANCELLATION_REQUEST_ACCEPTED: 'CANCELLATION_REQUEST_ACCEPTED',
  OrderStatus.DELIVERING: 'DELIVERING',
  OrderStatus.SUCCEED: 'SUCCEED',
  OrderStatus.CANCELED: 'CANCELED',
};
