import 'package:shopfeeforemployee/core/common/enum/cancel_request_action.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_action_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';

abstract class OrderDetailRepository {
  Future<OrderDetailEntity> getOrderDetail(String orderId);

  Future<List<EventLogEntity>> getEventLogs(String orderId);

  Future<void> doActionsInOrder(String orderId, OrderActionEntity orderAction);

  Future<String> getFCMToken(String userId);

  Future<void> sendOrderMessage(
      String title, String body, String destinationId, String fcmToken);
}
