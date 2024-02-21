part of shipping_order;

abstract class ShippingOrderEvent extends Equatable {
  const ShippingOrderEvent();
}

class LoadShippingOrder extends ShippingOrderEvent {
  final OrderStatus orderStatus;

  const LoadShippingOrder({
    required this.orderStatus,
  });

  @override
  List<Object> get props => [orderStatus];
}

class LoadMoreShippingOrder extends ShippingOrderEvent {
  final OrderStatus orderStatus;

  const LoadMoreShippingOrder({
    required this.orderStatus,
  });

  @override
  List<Object> get props => [orderStatus];
}