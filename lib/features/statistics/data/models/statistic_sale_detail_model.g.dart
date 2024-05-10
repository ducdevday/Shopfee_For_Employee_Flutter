// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_sale_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticSaleDetailModel _$StatisticSaleDetailModelFromJson(
        Map<String, dynamic> json) =>
    StatisticSaleDetailModel(
      time: json['time'] as String,
      orderCount: json['orderCount'] as int,
      totalItemPrice: (json['totalItemPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$StatisticSaleDetailModelToJson(
        StatisticSaleDetailModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'orderCount': instance.orderCount,
      'totalItemPrice': instance.totalItemPrice,
    };
