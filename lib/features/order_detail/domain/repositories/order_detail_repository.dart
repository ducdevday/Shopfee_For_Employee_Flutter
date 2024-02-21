import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';

abstract class OrderDetailRepository {
  Future<OrderDetailEntity> getOrderDetail(String orderId);
  Future<List<EventLogEntity>> getEventLogs(String orderId);
  Future<void> addEventLog(String orderId, EventLogEntity eventLog);
  Future<String> getFCMToken(String userId);
  Future<void> sendOrderMessage(String title, String body, String destinationId, String fcmToken);
  Future<void> completeTransaction(String transactionId);
}