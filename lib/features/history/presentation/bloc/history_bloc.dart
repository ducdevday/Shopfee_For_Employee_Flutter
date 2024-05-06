part of history;

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryUseCase _historyUseCase;

  HistoryBloc(this._historyUseCase) : super(HistoryInitial()) {
    on<HistoryLoadInformation>(_onHistoryLoadInformation);
    on<HistoryLoadMoreInformation>(_onHistoryLoadMoreInformation);
    on<HistoryRefreshInformation>(_onHistoryRefreshInformation);
  }

  FutureOr<void> _onHistoryLoadInformation(
      HistoryLoadInformation event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoadInProcess());
      final params = HistoryParams(
          page: event.initPage, size: event.initSize, key: event.searchQuery);
      EasyLoading.show();
      final historyList =
          await _historyUseCase.getHistoryByStatus(params, event.orderStatus);
      EasyLoading.dismiss();
      emit(HistoryLoadSuccess(
          orderStatus: event.orderStatus,
          historyList: historyList,
          page: event.initPage,
          size: event.initSize,
          searchQuery: event.searchQuery));
    } catch (e) {
      emit(HistoryLoadFailure());
    }
  }

  FutureOr<void> _onHistoryLoadMoreInformation(
      HistoryLoadMoreInformation event, Emitter<HistoryState> emit) async {
    try {
      if (state is HistoryLoadSuccess) {
        final currentState = state as HistoryLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));

        final params = HistoryParams(
            page: currentState.page + 1,
            size: currentState.size,
            key: currentState.searchQuery);
        final historyList = await _historyUseCase.getHistoryByStatus(
            params, currentState.orderStatus);
        if (historyList.isNotEmpty) {
          emit(currentState.copyWith(
              historyList: List.from(currentState.historyList)
                ..addAll(historyList),
              page: currentState.page + 1,
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onHistoryRefreshInformation(
      HistoryRefreshInformation event, Emitter<HistoryState> emit) async {
    try {
      if (state is HistoryLoadSuccess) {
        final currentState = state as HistoryLoadSuccess;
        final params = HistoryParams(
            page: event.initPage,
            size: event.initSize,
            key: currentState.searchQuery);
        final historyList = await _historyUseCase.getHistoryByStatus(
            params, currentState.orderStatus);
        emit(currentState.copyWith(
            historyList: historyList,
            page: event.initPage,
            size: event.initSize,
            isLoadMore: false,
            cannotLoadMore: false));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
