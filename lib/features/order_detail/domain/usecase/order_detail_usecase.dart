import 'package:shopfeeforemployee/core/common/enum/order_event_type.dart';
import 'package:shopfeeforemployee/core/socket/socket_method.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_action_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/repositories/order_detail_repository.dart';

abstract class OrderDetailUseCase {
  Future<OrderDetailEntity> getOrderDetail(String orderId);

  Future<List<EventLogEntity>> getEventLogs(String orderId);

  Future<void> acceptOrder(String userId, String orderId);

  Future<void> refuseOrder(String userId, String orderId, String description);

  Future<void> preparedOrder(String userId, String orderId);

  Future<void> deliveryOrder(String userId, String orderId);

  Future<void> fulfillOrder(String userId, String orderId);

  Future<void> markBoomOrder(String userId, String orderId);

  Future<void> acceptRequestCancel(String userId, String orderId);

  Future<void> refuseRequestCancel(String userId, String orderId);

  Future<String> getCancelRequestReason(String orderId);
}

class OrderDetailUseCaseImpl extends OrderDetailUseCase {
  final OrderDetailRepository _orderDetailRepository;
  final SocketMethod _socketMethod;

  OrderDetailUseCaseImpl(this._orderDetailRepository, this._socketMethod);

  @override
  Future<OrderDetailEntity> getOrderDetail(String orderId) async {
    return await _orderDetailRepository.getOrderDetail(orderId);
  }

  @override
  Future<List<EventLogEntity>> getEventLogs(String orderId) async {
    return await _orderDetailRepository.getEventLogs(orderId);
  }

  @override
  Future<void> acceptRequestCancel(String userId, String orderId) async {
    _socketMethod.updateOrder(userId: userId, orderId: orderId);
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.ACCEPT_ORDER_CANCELLATION);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> refuseRequestCancel(String userId, String orderId) async {
    _socketMethod.updateOrder(userId: userId, orderId: orderId);
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.REFUSE_ORDER_CANCELLATION);
    return await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
  }

  @override
  Future<void> acceptOrder(String userId, String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.ACCEPT_ORDER);
    final result =
        await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
    _socketMethod.updateOrder(userId: userId, orderId: orderId);
    return result;
  }

  @override
  Future<void> deliveryOrder(String userId, String orderId) async {
    final orderAction =
        OrderActionEntity(orderEvent: OrderEventType.START_SHIPPING);
    final result =
        await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
    _socketMethod.updateOrder(userId: userId, orderId: orderId);
    return result;
  }

  @override
  Future<void> fulfillOrder(String userId, String orderId) async {
    final orderAction = OrderActionEntity(orderEvent: OrderEventType.FULFILL);
    final result =
        await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
    _socketMethod.updateOrder(userId: userId, orderId: orderId);
    return result;
  }

  @override
  Future<void> markBoomOrder(String userId, String orderId) async {
    final orderAction = OrderActionEntity(orderEvent: OrderEventType.BOOM);
    final result =
        await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
    _socketMethod.updateOrder(userId: userId, orderId: orderId);
    return result;
  }

  @override
  Future<void> preparedOrder(String userId, String orderId) async {
    final orderAction = OrderActionEntity(orderEvent: OrderEventType.PREPARED);
    final result =
        await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
    _socketMethod.updateOrder(userId: userId, orderId: orderId);
    return result;
  }

  @override
  Future<void> refuseOrder(
      String userId, String orderId, String description) async {
    final orderAction = OrderActionEntity(
        orderEvent: OrderEventType.EMPLOYEE_REFUSE, description: description);
    final result =
        await _orderDetailRepository.doActionsInOrder(orderId, orderAction);
    _socketMethod.updateOrder(userId: userId, orderId: orderId);
    return result;
  }

  @override
  Future<String> getCancelRequestReason(String orderId) async {
    final reason = await _orderDetailRepository.getCancelRequestReason(orderId);
    return reason;
  }
}
