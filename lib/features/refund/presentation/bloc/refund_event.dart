part of refund;

abstract class RefundEvent extends Equatable {
  const RefundEvent();
}

class RefundInitRequest extends RefundEvent {
  @override
  List<Object> get props => [];
}

class RefundLoadDetail extends RefundEvent {
  final String orderId;

  const RefundLoadDetail({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class RefundAcceptButtonPressed extends RefundEvent {
  final String orderId;

  const RefundAcceptButtonPressed({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class RefundRejectButtonPressed extends RefundEvent {
  final String orderId;

  const RefundRejectButtonPressed({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}
