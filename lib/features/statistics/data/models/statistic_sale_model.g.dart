// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticSaleModel _$StatisticSaleModelFromJson(Map<String, dynamic> json) =>
    StatisticSaleModel(
      totalOrderCount: json['totalOrderCount'] as int,
      totalItemPrice: (json['totalItemPrice'] as num).toDouble(),
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) =>
              StatisticSaleDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatisticSaleModelToJson(StatisticSaleModel instance) =>
    <String, dynamic>{
      'totalOrderCount': instance.totalOrderCount,
      'totalItemPrice': instance.totalItemPrice,
      'statistics': instance.statistics,
    };
