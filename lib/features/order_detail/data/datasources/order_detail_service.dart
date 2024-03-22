import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/core/base/fcm_service.dart';
import 'package:shopfeeforemployee/core/common/enum/cancel_request_action.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/event_log_model.dart';

class OrderDetailService {
  Future<Response> getOrderDetail(String orderId) async {
    final response = await DioService.instance
        .get("${DioService.orderPath}/$orderId/details");
    return response;
  }

  Future<Response> getEventLogs(String orderId) async {
    final response = await DioService.instance
        .get("${DioService.orderPath}/$orderId/status-line");
    return response;
  }

  Future<Response> handleRequestCancel(
      String orderId, CancelRequestAction action) async {
    Map<String, dynamic> body = {
      "status": action.name,
    };
    final response = await DioService.instance.patch(
        "${DioService.orderPath}/$orderId/process-cancellation-request",
        data: body);
    return response;
  }

  Future<Response> addEventLog(String orderId, EventLogModel eventLog) async {
    Map<String, dynamic> body = {
      "orderStatus": eventLog.orderStatus?.name,
      "description": eventLog.description
    };
    final response = await DioService.instance
        .patch("${DioService.orderPath}/$orderId/employee/event", data: body);
    return response;
  }

  Future<Response> completeTransaction(String transactionId) async {
    final response = await DioService.instance
        .patch("${DioService.transactionPath}/complete/$transactionId");
    return response;
  }

  Future<Response> sendOrderMessage(
      String title, String body, String destinationId, String fcmToken) async {
    Map<String, dynamic> data = {
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "status": "done",
        "body": body,
        "title": title,
        "destinationId": destinationId
      },
      "notification": {
        "title": title,
        "body": body,
        "android_channel_id": "shopfee"
      },
      //! Sử dụng "to" thì khi đóng ứng dụng sẽ không nhận được thông báo
      // "to": fcmToken
      "registration_ids": [fcmToken],
    };
    final response =
        await FCMService.instance.post("${FCMService.FCM_PATH}", data: data);
    return response;
  }
}
