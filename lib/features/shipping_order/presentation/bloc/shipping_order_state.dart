part of 'shipping_order_bloc.dart';

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
  final List<ShippingOrderEntity> createdOrderList;
  final List<ShippingOrderEntity> acceptedOrderList;
  final List<ShippingOrderEntity> deliveringOrderList;
  // final List<ShippingOrderEntity> canceledOrderList;
  // final List<ShippingOrderEntity> succeedOrderList;

  const ShippingOrderLoaded({this.createdOrderList = const [],
    this.acceptedOrderList = const [],
    this.deliveringOrderList = const [],
    // this.canceledOrderList = const [],
    // this.succeedOrderList = const []
  });

  @override
  List<Object> get props =>
      [
        createdOrderList,
        acceptedOrderList,
        deliveringOrderList,
        // canceledOrderList,
        // succeedOrderList,
      ];

  ShippingOrderLoaded copyWith({
    List<ShippingOrderEntity>? createdOrderList,
    List<ShippingOrderEntity>? acceptedOrderList,
    List<ShippingOrderEntity>? deliveringOrderList,
    List<ShippingOrderEntity>? canceledOrderList,
    List<ShippingOrderEntity>? succeedOrderList,
  }) {
    return ShippingOrderLoaded(
      createdOrderList: createdOrderList ?? this.createdOrderList,
      acceptedOrderList: acceptedOrderList ?? this.acceptedOrderList,
      deliveringOrderList: deliveringOrderList ?? this.deliveringOrderList,
      // canceledOrderList: canceledOrderList ?? this.canceledOrderList,
      // succeedOrderList: succeedOrderList ?? this.succeedOrderList,
    );
  }
}

class ShippingOrderError extends ShippingOrderState {
  @override
  List<Object> get props => [];
}