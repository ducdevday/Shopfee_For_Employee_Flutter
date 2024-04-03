part of history;

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class HistoryLoadInformation extends HistoryEvent {
  final OrderStatus orderStatus;
  final int initPage;
  final int initSize;
  final String? searchQuery;

  const HistoryLoadInformation({
    required this.orderStatus,
    required this.initPage,
    required this.initSize,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [orderStatus, initPage, initSize, searchQuery];
}

class HistoryLoadMoreInformation extends HistoryEvent {
  final OrderStatus orderStatus;

  const HistoryLoadMoreInformation({
    required this.orderStatus,
  });

  @override
  List<Object> get props => [orderStatus];
}
