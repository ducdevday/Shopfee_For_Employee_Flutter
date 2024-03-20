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

class ShippingOrderLoadSuccess extends OrdersState {
  final List<OrderInformationEntity> orderList;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const ShippingOrderLoadSuccess({
    required this.orderList,
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });

  @override
  List<Object> get props =>
      [orderList, page, size, isLoadMore, cannotLoadMore,];

  ShippingOrderLoadSuccess copyWith({
    List<OrderInformationEntity>? orderList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return ShippingOrderLoadSuccess(
      orderList: orderList ?? this.orderList,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class ShippingOrderLoadFailure extends OrdersState {
  @override
  List<Object> get props => [];
}