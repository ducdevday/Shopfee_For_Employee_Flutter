import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/statistics/data/models/statistic_sale_detail_model.dart';

part 'statistic_sale_model.g.dart';

@JsonSerializable()
class StatisticSaleModel {
  final int totalOrderCount;
  final double totalItemPrice;
  final List<StatisticSaleDetailModel> statistics;

  const StatisticSaleModel({
    required this.totalOrderCount,
    required this.totalItemPrice,
    required this.statistics,
  });

  factory StatisticSaleModel.fromJson(Map<String, dynamic> json) {
    return _$StatisticSaleModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StatisticSaleModelToJson(this);
  }

}