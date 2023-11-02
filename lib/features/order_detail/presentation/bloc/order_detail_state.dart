part of 'order_detail_bloc.dart';

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();
}

class OrderDetailInitial extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailLoading extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailLoaded extends OrderDetailState {
  final OrderDetailEntity orderDetail;
  final List<EventLogEntity> eventLogs;
  final List<OrderStatus> ordersTracking;
  final String reasonCancel;

  const OrderDetailLoaded({
    required this.orderDetail,
    required this.eventLogs,
    this.ordersTracking = const [
      OrderStatus.CREATED,
      OrderStatus.ACCEPTED,
      OrderStatus.DELIVERING,
      OrderStatus.SUCCEED
    ],
    this.reasonCancel = "This product was sold out",
  });

  @override
  List<Object> get props => [orderDetail, eventLogs, ordersTracking, reasonCancel];

  OrderStatus get currentOrderStatus => eventLogs.last.orderStatus;

  int get currentIndex => eventLogs.last.orderStatus.index;

  OrderStatus get nextOrderStatus => ordersTracking.elementAt(currentIndex + 1);

  OrderDetailLoaded copyWith({
    OrderDetailEntity? orderDetail,
    List<EventLogEntity>? eventLogs,
    List<OrderStatus>? ordersTracking,
    String? reasonCancel,
  }) {
    return OrderDetailLoaded(
      orderDetail: orderDetail ?? this.orderDetail,
      eventLogs: eventLogs ?? this.eventLogs,
      ordersTracking: ordersTracking ?? this.ordersTracking,
      reasonCancel: reasonCancel ?? this.reasonCancel,
    );
  }
}

class OrderDetailFinished extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailError extends OrderDetailState {
  @override
  List<Object> get props => [];
}
