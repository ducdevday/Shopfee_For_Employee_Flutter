import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/repositories/order_detail_repository.dart';

abstract class OrderDetailUseCase {
  Future<OrderDetailEntity> getOrderDetail(String orderId);

  Future<List<EventLogEntity>> getEventLogs(String orderId);

  Future<void> addEventLog(String orderId, EventLogEntity eventLog);

  Future<String> getFCMToken(String userId);

  Future<void> sendOrderMessage(
      OrderStatus status, String orderId, String fcmToken);

  Future<void> completeTransaction(String transactionId);
}

class OrderDetailUseCaseImpl extends OrderDetailUseCase {
  final OrderDetailRepository _orderDetailRepository;

  OrderDetailUseCaseImpl(this._orderDetailRepository);

  @override
  Future<OrderDetailEntity> getOrderDetail(String orderId) async {
    return await _orderDetailRepository.getOrderDetail(orderId);
  }

  @override
  Future<List<EventLogEntity>> getEventLogs(String orderId) async {
    return await _orderDetailRepository.getEventLogs(orderId);
  }

  @override
  Future<void> addEventLog(String orderId, EventLogEntity eventLog) async {
    return await _orderDetailRepository.addEventLog(orderId, eventLog);
  }

  @override
  Future<String> getFCMToken(String userId) async {
    return await _orderDetailRepository.getFCMToken(userId);
  }

  @override
  Future<void> sendOrderMessage(
      OrderStatus status, String orderId, String fcmToken) async {
    final message = formatMessage(status, orderId);
    return await _orderDetailRepository.sendOrderMessage(
        message!["title"], message["body"], orderId, fcmToken);
  }

  Map<String, dynamic>? formatMessage(OrderStatus status, String orderId) {
    late Map<String, dynamic> result;
    if (status == OrderStatus.ACCEPTED) {
      result = {
        "title": "Shopfee Announce",
        "body":
            "Your order $orderId was accepted by employee. Please wait for us to process your order."
      };
      return result;
    } else if (status == OrderStatus.DELIVERING) {
      result = {
        "title": "Shopfee Announce",
        "body":
            "Your order $orderId is delivering. Please pay attention to your phone in case the shipper call you."
      };
      return result;
    } else if (status == OrderStatus.SUCCEED) {
      result = {
        "title": "Shopfee Announce",
        "body":
            "Your order $orderId was got by you. Thank you for choosing Shopfee."
      };
      return result;
    } else if (status == OrderStatus.CANCELED) {
      result = {
        "title": "Shopfee Announce",
        "body": "Your order $orderId was canceled. Please tap to see details."
      };
      return result;
    }
    return null;
  }

  @override
  Future<void> completeTransaction(String transactionId) async {
    return await _orderDetailRepository.completeTransaction(transactionId);
  }
}
