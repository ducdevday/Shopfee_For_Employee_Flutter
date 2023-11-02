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

class AddEventLog extends OrderDetailEvent {
  final String id;
  final EventLogEntity eventLog;

  const AddEventLog({
    required this.id,
    required this.eventLog,
  });

  @override
  List<Object> get props => [id, eventLog];
}

class ChooseReasonCancel extends OrderDetailEvent {
  final String reason;

  const ChooseReasonCancel({
    required this.reason,
  });

  @override
  List<Object> get props => [reason];
}
