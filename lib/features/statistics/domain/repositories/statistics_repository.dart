import 'package:shopfeeforemployee/features/statistics/domain/entities/statistic_sale_entity.dart';

abstract class StatisticsRepository {
  Future<StatisticSaleEntity> getSaleStatistic(
      String employeeId, String startDate, String endDate);
}