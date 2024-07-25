import 'package:json_annotation/json_annotation.dart';

part 'statistic_sale_detail_model.g.dart';

@JsonSerializable()
class StatisticSaleDetailModel {
  final String time;
  final int orderCount;
  final double totalItemPrice;

  const StatisticSaleDetailModel({
    required this.time,
    required this.orderCount,
    required this.totalItemPrice,
  });

  factory StatisticSaleDetailModel.fromJson(Map<String, dynamic> json) {
    return _$StatisticSaleDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StatisticSaleDetailModelToJson(this);
  }


}
