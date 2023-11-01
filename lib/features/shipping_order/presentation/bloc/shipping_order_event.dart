part of 'shipping_order_bloc.dart';

abstract class ShippingOrderEvent extends Equatable {
  const ShippingOrderEvent();
}

class LoadShippingOrder extends ShippingOrderEvent {
  @override
  List<Object> get props => [];
}