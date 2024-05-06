import 'package:shopfeeforemployee/core/common/enum/order_event_type.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_action_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/repositories/order_detail_repository.dart';

abstract class OrderDetailUseCase {
  Future<OrderDetailEntity> getOrderDetail(String orderId);

  Future<List<EventLogEntity>> getEventLogs(String orderId);

  Future<void> acceptOrder(String orderId);

  Future<void> refuseOrder(String orderId, String description);

  Future<void> preparedOrder(String orderId);

  Future<void> deliveryOrder(String orderId);

  Future<void> fulfillOrder(String orderId);

  Future<void> markBoomOrder(String orderId);

  Future<void> acceptRequestCancel(String orderId);

  Future<void> refuseRequestCancel(String orderId);

  Future<String> getCancelRequestReason(String orderId);
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
  Future<void> acceptRequestCancel(String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.CANCEL_REQUEST_ACCEPT);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> refuseRequestCancel(String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.CANCEL_REQUEST_REFUSE);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> acceptOrder(String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.ORDER_ACCEPT);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> deliveryOrder(String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.START_SHIPPING);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> fulfillOrder(String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.ORDER_FULFILL);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> markBoomOrder(String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.ORDER_BOOM);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> preparedOrder(String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.READY_SHIPPING);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> refuseOrder(String orderId, String description) async {
    final orderAction = OrderActionEntity(
        orderEvent: OrderEventType.ORDER_REFUSE, description: description);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<String> getCancelRequestReason(String orderId) async {
    final reason = await _orderDetailRepository.getCancelRequestReason(orderId);
    return reason;
  }
}
