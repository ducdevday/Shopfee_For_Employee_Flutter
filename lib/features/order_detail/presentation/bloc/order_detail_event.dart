part of 'order_detail_bloc.dart';

abstract class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();
}

class LoadOrderDetail extends OrderDetailEvent {
  final String id;

  const LoadOrderDetail({
    required this.id,
  });

  @override
  List<Object> get props => [id];


}