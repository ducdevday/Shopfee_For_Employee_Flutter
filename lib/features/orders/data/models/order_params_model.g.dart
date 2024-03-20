// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderParamsModel _$OrderParamsModelFromJson(Map<String, dynamic> json) =>
    OrderParamsModel(
      orderType: json['orderType'] as String,
      orderStatus: json['orderStatus'] as String,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$OrderParamsModelToJson(OrderParamsModel instance) =>
    <String, dynamic>{
      'orderType': instance.orderType,
      'orderStatus': instance.orderStatus,
      'page': instance.page,
      'size': instance.size,
    };
