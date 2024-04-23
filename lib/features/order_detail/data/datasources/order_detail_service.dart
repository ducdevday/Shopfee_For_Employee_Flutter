import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/core/base/fcm_service.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_action_model.dart';

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

  Future<Response> doActionsInOrder(String orderId, OrderActionModel orderActionModel) async {
    final response = await DioService.instance
        .patch("${DioService.orderPath}/$orderId/employee/event", data: orderActionModel.toJson());
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
