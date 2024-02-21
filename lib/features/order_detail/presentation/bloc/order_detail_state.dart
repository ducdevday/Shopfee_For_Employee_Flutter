part of order_detail;

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();
}

class OrderDetailInitial extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailLoadInProcess extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailLoadSuccess extends OrderDetailState {
  final OrderDetailEntity orderDetail;
  final List<EventLogEntity> eventLogs;
  final List<OrderStatus> ordersTracking;
  final ReasonCancelType? reasonCancel;
  final bool isAddEventLogClicked;

  const OrderDetailLoadSuccess(
      {required this.orderDetail,
      required this.eventLogs,
      this.ordersTracking = const [
        OrderStatus.CREATED,
        OrderStatus.ACCEPTED,
        OrderStatus.DELIVERING,
        OrderStatus.SUCCEED
      ],
      this.reasonCancel,
      this.isAddEventLogClicked = false});

  @override
  List<Object?> get props => [
        orderDetail,
        eventLogs,
        ordersTracking,
        reasonCancel,
        isAddEventLogClicked,
      ];

  OrderStatus? get currentOrderStatus => eventLogs.last.orderStatus;

  int? get currentIndex => eventLogs.last.orderStatus?.index;

  OrderStatus? get nextOrderStatus =>
      currentIndex == null ? null : ordersTracking.elementAt(currentIndex! + 1);

  OrderDetailLoadSuccess copyWith({
    OrderDetailEntity? orderDetail,
    List<EventLogEntity>? eventLogs,
    List<OrderStatus>? ordersTracking,
    ReasonCancelType? reasonCancel,
    bool? isAddEventLogClicked,
  }) {
    return OrderDetailLoadSuccess(
      orderDetail: orderDetail ?? this.orderDetail,
      eventLogs: eventLogs ?? this.eventLogs,
      ordersTracking: ordersTracking ?? this.ordersTracking,
      reasonCancel: reasonCancel ?? this.reasonCancel,
      isAddEventLogClicked: isAddEventLogClicked ?? this.isAddEventLogClicked,
    );
  }
}

class OrderDetailFinished extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailLoadFailure extends OrderDetailState {
  @override
  List<Object> get props => [];
}
