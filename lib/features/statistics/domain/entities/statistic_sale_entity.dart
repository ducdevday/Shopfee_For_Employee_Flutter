import 'package:shopfeeforemployee/features/statistics/data/models/statistic_sale_detail_model.dart';
import 'package:shopfeeforemployee/features/statistics/data/models/statistic_sale_model.dart';
import 'package:shopfeeforemployee/features/statistics/domain/entities/statistic_sale_detail_entity.dart';

class StatisticSaleEntity {
  final int totalOrderCount;
  final double totalItemPrice;
  final List<StatisticSaleDetailEntity> statistics;

  const StatisticSaleEntity({
    required this.totalOrderCount,
    required this.totalItemPrice,
    required this.statistics,
  });

  factory StatisticSaleEntity.fromModel(StatisticSaleModel model) {
    return StatisticSaleEntity(
      totalOrderCount: model.totalOrderCount,
      totalItemPrice: model.totalItemPrice,
      statistics: model.statistics
          .map((e) => StatisticSaleDetailEntity.fromModel(e))
          .toList(),
    );
  }}
