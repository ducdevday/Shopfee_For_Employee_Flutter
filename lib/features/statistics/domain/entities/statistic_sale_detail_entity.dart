import 'package:shopfeeforemployee/features/statistics/data/models/statistic_sale_detail_model.dart';

class StatisticSaleDetailEntity {
  final String time;
  final int orderCount;
  final double totalItemPrice;

  const StatisticSaleDetailEntity({
    required this.time,
    required this.orderCount,
    required this.totalItemPrice,
  });

  factory StatisticSaleDetailEntity.fromModel(StatisticSaleDetailModel model) {
    return StatisticSaleDetailEntity(
        time: model.time,
        orderCount: model.orderCount,
        totalItemPrice: model.totalItemPrice);
  }
}
