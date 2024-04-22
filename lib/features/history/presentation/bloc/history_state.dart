part of history;

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoadInProcess extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoadSuccess extends HistoryState {
  final OrderStatus orderStatus;
  final List<HistoryEntity> historyList;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;
  final String? searchQuery;

  const HistoryLoadSuccess({
    required this.orderStatus,
    required this.historyList,
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [
        orderStatus,
        historyList,
        page,
        size,
        isLoadMore,
        cannotLoadMore,
        searchQuery,
      ];

  HistoryLoadSuccess copyWith({
    OrderStatus? orderStatus,
    List<HistoryEntity>? historyList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
    String? searchQuery,
  }) {
    return HistoryLoadSuccess(
      orderStatus: orderStatus ?? this.orderStatus,
      historyList: historyList ?? this.historyList,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class HistoryLoadFailure extends HistoryState {
  @override
  List<Object> get props => [];
}
