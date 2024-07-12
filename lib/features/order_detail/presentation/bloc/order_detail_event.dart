part of order_detail;

abstract class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();
}

class OrderDetailLoadInformation extends OrderDetailEvent {
  final String orderId;
  final bool haveChanged;
  const OrderDetailLoadInformation({
    required this.orderId,
    required this.haveChanged
  });

  @override
  List<Object> get props => [orderId, haveChanged];
}

class OrderDetailRefreshInformation extends OrderDetailEvent {
  final String orderId;
  const OrderDetailRefreshInformation({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class OrderDetailDoAction extends OrderDetailEvent {
  final OrderEventType orderEventType;
  final String orderId;
  final String? description;

  const OrderDetailDoAction({
    required this.orderEventType,
    required this.orderId,
    this.description,
  });

  @override
  List<Object?> get props => [orderEventType, orderId, description];
}

class OrderDetailChooseReasonCancel extends OrderDetailEvent {
  final ReasonCancelType reasonCancel;

  const OrderDetailChooseReasonCancel({
    required this.reasonCancel,
  });

  @override
  List<Object> get props => [reasonCancel];
}
