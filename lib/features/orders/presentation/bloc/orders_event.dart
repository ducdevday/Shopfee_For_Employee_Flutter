part of orders;

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class OrderLoadInformation extends OrdersEvent {
  final OrderType orderType;
  final OrderStatus orderStatus;
  final int initPage;
  final int initSize;

  const OrderLoadInformation({
    required this.orderType,
    required this.orderStatus,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [orderType, orderStatus, initPage, initSize];
}

class OrderLoadMoreInformation extends OrdersEvent {
  final OrderType orderType;
  final OrderStatus orderStatus;

  const OrderLoadMoreInformation({
    required this.orderType,
    required this.orderStatus,
  });

  @override
  List<Object> get props => [orderType, orderStatus];
}