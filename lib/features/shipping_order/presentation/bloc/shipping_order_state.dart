part of shipping_order;

abstract class ShippingOrderState extends Equatable {
  const ShippingOrderState();
}

class ShippingOrderInitial extends ShippingOrderState {
  @override
  List<Object> get props => [];
}

class ShippingOrderLoading extends ShippingOrderState {
  @override
  List<Object> get props => [];
}

class ShippingOrderLoaded extends ShippingOrderState {
  final List<ShippingOrderEntity> orderList;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const ShippingOrderLoaded({
    required this.orderList,
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });

  @override
  List<Object> get props =>
      [orderList, page, size, isLoadMore, cannotLoadMore,];

  ShippingOrderLoaded copyWith({
    List<ShippingOrderEntity>? orderList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return ShippingOrderLoaded(
      orderList: orderList ?? this.orderList,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class ShippingOrderError extends ShippingOrderState {
  @override
  List<Object> get props => [];
}