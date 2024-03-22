part of order_detail;

abstract class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();
}

class OrderDetailLoadInformation extends OrderDetailEvent {
  final String orderId;

  const OrderDetailLoadInformation({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class OrderDetailAddEventLog extends OrderDetailEvent {
  final String orderId;
  final EventLogEntity eventLog;

  const OrderDetailAddEventLog({
    required this.orderId,
    required this.eventLog,
  });

  @override
  List<Object> get props => [orderId, eventLog];
}

class OrderDetailAcceptRequestCancel extends OrderDetailEvent {
  final String orderId;

  const OrderDetailAcceptRequestCancel({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class OrderDetailRefuseRequestCancel extends OrderDetailEvent {
  final String orderId;

  const OrderDetailRefuseRequestCancel({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class OrderDetailChooseReasonCancel extends OrderDetailEvent {
  final ReasonCancelType reasonCancel;

  const OrderDetailChooseReasonCancel({
    required this.reasonCancel,
  });

  @override
  List<Object> get props => [reasonCancel];
}
