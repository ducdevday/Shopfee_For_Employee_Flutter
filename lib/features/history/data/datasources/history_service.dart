import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';

class HistoryService extends BaseService {
  Future<Response> getHistoryStatus(
      int page, int size, OrderStatus status, String searchQuery) async {
    Map<String, dynamic> query = {"page": page, "size": size, "key": searchQuery};
    final response = await dio.get("${BaseService.orderPath}/history/${status.name}",
        queryParameters: query);
    return response;
  }
}
