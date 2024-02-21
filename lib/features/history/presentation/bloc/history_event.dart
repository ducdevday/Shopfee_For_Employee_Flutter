part of history;

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class HistoryLoadInformation extends HistoryEvent {
  final String searchQuery;

  HistoryLoadInformation({this.searchQuery = ""});

  @override
  List<Object> get props => [];
}

class HistoryLoadSucceedOrder extends HistoryEvent {
  const HistoryLoadSucceedOrder();

  @override
  List<Object> get props => [];
}

class HistoryLoadCanceledOrder extends HistoryEvent {
  const HistoryLoadCanceledOrder();

  @override
  List<Object> get props => [];
}
