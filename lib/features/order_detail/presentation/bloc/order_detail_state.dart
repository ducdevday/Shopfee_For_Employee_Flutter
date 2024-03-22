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
  final ReasonCancelType? reasonCancel;
  final bool isAddEventLogClicked;

  const OrderDetailLoadSuccess(
      {required this.orderDetail,
      required this.eventLogs,
      this.reasonCancel,
      this.isAddEventLogClicked = false});

  EventLogEntity get lastEventLog => eventLogs.first;

  @override
  List<Object?> get props => [
        orderDetail,
        eventLogs,
        reasonCancel,
        isAddEventLogClicked,
      ];

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
