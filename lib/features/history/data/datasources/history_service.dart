import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/history/data/models/history_params.dart';

class HistoryService {
  Future<Response> getHistoryStatus(
      HistoryParams params, OrderStatus status) async {
    final response = await DioService.instance.get("${DioService.orderPath}/history/${status.name}",
        queryParameters: params.toJson());
    return response;
  }
}
