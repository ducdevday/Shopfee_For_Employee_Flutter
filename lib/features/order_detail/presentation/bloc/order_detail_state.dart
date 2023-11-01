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
  final OrderDetailEntity orderDetailEntity;

  const OrderDetailLoaded({required this.orderDetailEntity});

  @override
  List<Object> get props => [orderDetailEntity];
}

class OrderDetailError extends OrderDetailState {
  @override
  List<Object> get props => [];
}