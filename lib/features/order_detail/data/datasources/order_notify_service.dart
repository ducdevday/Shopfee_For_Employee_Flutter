import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/notify_service.dart';

class OrderNotifyService extends NotifyService {
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
    final response = await dio.post("${NotifyService.path}", data: data);
    return response;
  }
}
