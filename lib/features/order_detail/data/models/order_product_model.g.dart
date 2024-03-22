// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      productId: json['productId'] as String?,
      name: json['name'] as String?,
      itemDetailList: (json['itemDetailList'] as List<dynamic>?)
          ?.map((e) =>
              OrderProductDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'itemDetailList': instance.itemDetailList,
    };
