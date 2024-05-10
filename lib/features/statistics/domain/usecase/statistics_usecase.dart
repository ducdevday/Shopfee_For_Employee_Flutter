import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/utils/format_util.dart';
import 'package:shopfeeforemployee/features/statistics/domain/entities/chart_line_data.dart';
import 'package:shopfeeforemployee/features/statistics/domain/entities/sale_data.dart';
import 'package:shopfeeforemployee/features/statistics/domain/entities/statistic_sale_entity.dart';
import 'package:shopfeeforemployee/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:shopfeeforemployee/features/template/domain/entities/template_entity.dart';
import 'package:shopfeeforemployee/features/template/domain/repositories/template_repository.dart';

abstract class StatisticsUseCase {
  Future<SaleData> getSaleStatistic(
      String employeeId, String startDate, String endDate);
}

class StatisticsUseCaseImpl extends StatisticsUseCase {
  final StatisticsRepository _statisticsRepository;

  StatisticsUseCaseImpl(this._statisticsRepository);

  @override
  Future<SaleData> getSaleStatistic(
      String employeeId, String startDate, String endDate) async {
    final saleStatistic = await _statisticsRepository.getSaleStatistic(
        employeeId, startDate, endDate);
    final saleData = SaleData(
        totalOrderCount: saleStatistic.totalOrderCount,
        totalItemPrice: saleStatistic.totalItemPrice,
        chartOrderCountData: saleStatistic.statistics
            .map((e) => ChartLineData(
                time: FormatUtil.formattedStatisticStringToDatetime(e.time)!,
                value: e.orderCount.toDouble()))
            .toList(),
        chartItemPriceData: saleStatistic.statistics
            .map((e) => ChartLineData(
                time: FormatUtil.formattedStatisticStringToDatetime(e.time)!,
                value: e.totalItemPrice))
            .toList());
    return saleData;
  }
}
