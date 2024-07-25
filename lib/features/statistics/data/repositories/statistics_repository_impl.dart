import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/features/statistics/data/datasources/statistics_service.dart';
import 'package:shopfeeforemployee/features/statistics/data/models/statistic_sale_model.dart';
import 'package:shopfeeforemployee/features/statistics/domain/entities/statistic_sale_entity.dart';
import 'package:shopfeeforemployee/features/statistics/domain/repositories/statistics_repository.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsService _statisticsService;

  StatisticsRepositoryImpl(this._statisticsService);

  @override
  Future<StatisticSaleEntity> getSaleStatistic(
      String employeeId, String startDate, String endDate) async {
    final response = await _statisticsService.getSaleStatistic(
        employeeId, startDate, endDate);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final statisticSaleModel = StatisticSaleModel.fromJson(result.data!);
    final statisticSaleEntity =
        StatisticSaleEntity.fromModel(statisticSaleModel);
    return statisticSaleEntity;
  }
}
