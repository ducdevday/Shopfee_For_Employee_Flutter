part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class InitHistory extends HistoryEvent {
  @override
  List<Object> get props => [];
}

class LoadHistorySucceed extends HistoryEvent {
  const LoadHistorySucceed();

  @override
  List<Object> get props => [];
}

class LoadHistoryCanceled extends HistoryEvent {
  const LoadHistoryCanceled();

  @override
  List<Object> get props => [];
}
