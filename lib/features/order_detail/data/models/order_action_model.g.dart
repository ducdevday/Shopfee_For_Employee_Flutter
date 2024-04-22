// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderActionModel _$OrderActionModelFromJson(Map<String, dynamic> json) =>
    OrderActionModel(
      orderEvent: json['event'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$OrderActionModelToJson(OrderActionModel instance) =>
    <String, dynamic>{
      'event': instance.orderEvent,
      'description': instance.description,
    };
