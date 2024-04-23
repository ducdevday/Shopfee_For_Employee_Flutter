import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopfeeforemployee/core/common/enum/cancel_request_action.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/common/models/result_list.dart';
import 'package:shopfeeforemployee/features/order_detail/data/datasources/order_detail_service.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/event_log_model.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_action_model.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_detail_model.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_action_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/repositories/order_detail_repository.dart';

class OrderDetailRepositoryImpl implements OrderDetailRepository {
  final OrderDetailService _orderDetailService;

  OrderDetailRepositoryImpl(this._orderDetailService);

  @override
  Future<OrderDetailEntity> getOrderDetail(String orderId) async {
    final response = await _orderDetailService.getOrderDetail(orderId);
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);

    final orderDetailModel = OrderDetailModel.fromJson(result.data!);
    final orderDetailEntity = OrderDetailEntity.fromModel(orderDetailModel);
    return orderDetailEntity;
  }

  @override
  Future<List<EventLogEntity>> getEventLogs(String orderId) async {
    final response = await _orderDetailService.getEventLogs(orderId);
    final result = ResultList(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    final eventLogModels =
        result.data!.map((e) => EventLogModel.fromJson(e)).toList();
    final eventLogEntities =
        eventLogModels.map((e) => EventLogEntity.fromModel(e)).toList();
    return eventLogEntities;
  }

  @override
  Future<void> doActionsInOrder(String orderId, OrderActionEntity orderAction) async {
    final response = await _orderDetailService.doActionsInOrder(
        orderId, OrderActionModel.fromEntity(orderAction));
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
    );
  }

  @override
  Future<void> sendOrderMessage(
      String title, String body, String destinationId, String fcmToken) async {
    final response = await _orderDetailService.sendOrderMessage(
        title, body, destinationId, fcmToken);
  }

  @override
  Future<String> getFCMToken(String userId) async {
    final response =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    final data = response.data();
    final fcmToken = data!["fcmToken"];
    return fcmToken;
  }
}
