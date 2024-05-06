part of orders;

abstract class OrdersState extends Equatable {
  const OrdersState();
}

class OrdersInitial extends OrdersState {
  @override
  List<Object> get props => [];
}

class OrdersLoadInProcess extends OrdersState {
  @override
  List<Object> get props => [];
}

class OrderLoadSuccess extends OrdersState {
  final List<OrderInformationEntity> orderList;
  final OrderType orderType;
  final OrderStatus orderStatus;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const OrderLoadSuccess({
    required this.orderList,
    required this.orderType,
    required this.orderStatus,
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });

  @override
  List<Object> get props => [
        orderList,
        orderType,
        orderStatus,
        page,
        size,
        isLoadMore,
        cannotLoadMore,
      ];

  OrderLoadSuccess copyWith({
    List<OrderInformationEntity>? orderList,
    OrderType? orderType,
    OrderStatus? orderStatus,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return OrderLoadSuccess(
      orderList: orderList ?? this.orderList,
      orderType: orderType ?? this.orderType,
      orderStatus: orderStatus ?? this.orderStatus,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class OrderLoadFailure extends OrdersState {
  @override
  List<Object> get props => [];
}
