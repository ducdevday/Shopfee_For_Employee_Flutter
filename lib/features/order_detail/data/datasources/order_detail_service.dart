import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/event_log_model.dart';

class OrderDetailService extends BaseService {
  Future<Response> getOrderDetail(String orderId) async {
    final response = await dio.get("${BaseService.orderPath}/details/$orderId");
    return response;
  }

  Future<Response> getEventLogs(String orderId) async {
    final response = await dio.get("${BaseService.orderPath}/status/$orderId");
    return response;
  }

  Future<Response> addEventLog(String orderId, EventLogModel eventLog) async {
    Map<String, dynamic> body = {
      "orderStatus": eventLog.orderStatus.name,
      "description": eventLog.description
    };
    final response =
        await dio.patch("${BaseService.orderPath}/employee/$orderId", data: body);
    return response;
  }
}
