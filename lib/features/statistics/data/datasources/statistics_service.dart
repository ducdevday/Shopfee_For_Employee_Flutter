import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';

class StatisticsService {
  Future<Response> getSaleStatistic(
      String employeeId, String startDate, String endDate) async {
    Map<String, dynamic> params = {"start_date": startDate, "end_date": endDate};
    final response = await DioService.instance
        .get("${DioService.employeePath}/$employeeId/sale-statistics", queryParameters: params);
    return response;
  }
}
