part of order_detail;

abstract class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();
}

class LoadOrderDetail extends OrderDetailEvent {
  final String orderId;

  const LoadOrderDetail({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class AddEventLog extends OrderDetailEvent {
  final String orderId;
  final EventLogEntity eventLog;

  const AddEventLog({
    required this.orderId,
    required this.eventLog,
  });

  @override
  List<Object> get props => [orderId, eventLog];
}

class ChooseReasonCancel extends OrderDetailEvent {
  final ReasonCancelType reasonCancel;

  const ChooseReasonCancel({
    required this.reasonCancel,
  });

  @override
  List<Object> get props => [reasonCancel];
}
