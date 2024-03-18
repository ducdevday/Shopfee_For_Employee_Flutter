import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/core/base/fcm_service.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/event_log_model.dart';

class OrderDetailService {
  Future<Response> getOrderDetail(String orderId) async {
    final response = await DioService.instance
        .get("${DioService.orderPath}/details/$orderId");
    return response;
  }

  Future<Response> getEventLogs(String orderId) async {
    final response = await DioService.instance
        .get("${DioService.orderPath}/status/$orderId");
    return response;
  }

  Future<Response> addEventLog(String orderId, EventLogModel eventLog) async {
    Map<String, dynamic> body = {
      "orderStatus": eventLog.orderStatus?.name,
      "description": eventLog.description
    };
    final response = await DioService.instance
        .patch("${DioService.orderPath}/employee/$orderId", data: body);
    return response;
  }

  Future<Response> completeTransaction(String transactionId) async {
    final response = await DioService.instance
        .patch("${DioService.transactionPath}/complete/$transactionId");
    return response;
  }

  Future<Response> sendOrderMessage(String title, String body, String destinationId, String fcmToken) async {
    Map<String, dynamic> data = {
      "priority" :"high",
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
    final response = await FCMService.instance.post("${FCMService.FCM_PATH}", data: data);
    return response;
  }
}
