part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> historiesSucceed;
  final List<HistoryEntity> historiesCanceled;
  final int pageSucceed;
  final int pageCanceled;
  final bool isSucceedLoadMore;
  final bool isCanceledLoadMore;
  final bool cannotSucceedLoadMore;
  final bool cannotCanceledLoadMore;
  final int size;
  final String query;

  const HistoryLoaded({required this.historiesSucceed,
    required this.historiesCanceled,
    required this.pageSucceed,
    required this.pageCanceled,
    required this.size,
    this.isSucceedLoadMore = false,
    this.isCanceledLoadMore = false,
    this.cannotSucceedLoadMore = false,
    this.cannotCanceledLoadMore = false,
    this.query = ""
  });

  @override
  List<Object> get props =>
      [
        historiesSucceed,
        historiesCanceled,
        pageSucceed,
        pageCanceled,
        isSucceedLoadMore,
        isCanceledLoadMore,
        cannotSucceedLoadMore,
        cannotCanceledLoadMore,
        size,
        query,
      ];

  HistoryLoaded copyWith({
    List<HistoryEntity>? historiesSucceed,
    List<HistoryEntity>? historiesCanceled,
    int? pageSucceed,
    int? pageCanceled,
    bool? isSucceedLoadMore,
    bool? isCanceledLoadMore,
    bool? cannotSucceedLoadMore,
    bool? cannotCanceledLoadMore,
    int? size,
    String? query,
  }) {
    return HistoryLoaded(
      historiesSucceed: historiesSucceed ?? this.historiesSucceed,
      historiesCanceled: historiesCanceled ?? this.historiesCanceled,
      pageSucceed: pageSucceed ?? this.pageSucceed,
      pageCanceled: pageCanceled ?? this.pageCanceled,
      isSucceedLoadMore: isSucceedLoadMore ?? this.isSucceedLoadMore,
      isCanceledLoadMore: isCanceledLoadMore ?? this.isCanceledLoadMore,
      cannotSucceedLoadMore:
          cannotSucceedLoadMore ?? this.cannotSucceedLoadMore,
      cannotCanceledLoadMore:
          cannotCanceledLoadMore ?? this.cannotCanceledLoadMore,
      size: size ?? this.size,
      query: query ?? this.query,
    );
  }
}

class HistoryError extends HistoryState {
  @override
  List<Object> get props => [];
}
