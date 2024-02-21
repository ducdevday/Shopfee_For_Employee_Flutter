part of history;

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryUseCase _historyUseCase;

  HistoryBloc(this._historyUseCase) : super(HistoryInitial()) {
    on<HistoryLoadInformation>(_onHistoryLoadInformation);
    on<HistoryLoadSucceedOrder>(_onHistoryLoadSucceedOrder);
    on<HistoryLoadCanceledOrder>(_onHistoryLoadCanceledOrder);
  }

  FutureOr<void> _onHistoryLoadInformation(
      HistoryLoadInformation event, Emitter<HistoryState> emit) async {
    try {
      int pageSuccessInit = 1;
      int pageCancelInit = 1;
      int size = 5;
      emit(HistoryLoadInProcess());
      final historiesSucceed = await _historyUseCase.getHistoryByStatus(
          pageSuccessInit, size, OrderStatus.SUCCEED, event.searchQuery);

      final historiesCanceled = await _historyUseCase.getHistoryByStatus(
          pageCancelInit, size, OrderStatus.CANCELED, event.searchQuery);

      emit(HistoryLoadSuccess(
          historiesSucceed: historiesSucceed,
          historiesCanceled: historiesCanceled,
          pageSucceed: pageSuccessInit,
          pageCanceled: pageCancelInit,
          size: size,
          query: event.searchQuery));
    } catch (e) {
      emit(HistoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onHistoryLoadSucceedOrder(
      HistoryLoadSucceedOrder event, Emitter<HistoryState> emit) async {
    if (state is HistoryLoadSuccess) {
      try {
        final currentState = state as HistoryLoadSuccess;
        emit(currentState.copyWith(isSucceedLoadMore: true));
        await Future.delayed(const Duration(milliseconds: 1000));
        final historyList = await _historyUseCase.getHistoryByStatus(
            currentState.pageSucceed + 1,
            currentState.size,
            OrderStatus.SUCCEED,
            currentState.query);

        if (historyList.isNotEmpty) {
          emit(currentState.copyWith(
              historiesSucceed: List.from(currentState.historiesSucceed)
                ..addAll(historyList),
              pageSucceed: currentState.pageSucceed + 1,
              isSucceedLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotSucceedLoadMore: true));
        }
      } catch (e) {
        emit(HistoryLoadFailure());
        ExceptionUtil.handle(e);
      }
    }
  }

  FutureOr<void> _onHistoryLoadCanceledOrder(
      HistoryLoadCanceledOrder event, Emitter<HistoryState> emit) async {
    if (state is HistoryLoadSuccess) {
      try {
        final currentState = state as HistoryLoadSuccess;
        emit(currentState.copyWith(isCanceledLoadMore: true));
        await Future.delayed(const Duration(milliseconds: 1000));
        final historyList = await _historyUseCase.getHistoryByStatus(
            currentState.pageCanceled + 1,
            currentState.size,
            OrderStatus.CANCELED,
            currentState.query);

        if (historyList.isNotEmpty) {
          emit(currentState.copyWith(
              historiesCanceled: List.from(currentState.historiesCanceled)
                ..addAll(historyList),
              pageCanceled: currentState.pageCanceled + 1,
              isCanceledLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotCanceledLoadMore: true));
        }
      } catch (e) {
        emit(HistoryLoadFailure());
        ExceptionUtil.handle(e);
      }
    }
  }
}
