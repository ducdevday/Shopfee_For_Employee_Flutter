part of orders;

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersUseCase _ordersUseCase;

  OrdersBloc(this._ordersUseCase) : super(OrdersInitial()) {
    on<OrderLoadInformation>(_onOrderLoadInformation);
    on<OrderLoadMoreInformation>(_onOrderLoadMoreInformation);
    on<OrderRefreshInformation>(_onOrderRefreshInformation);
  }

  FutureOr<void> _onOrderLoadInformation(
      OrderLoadInformation event, Emitter<OrdersState> emit) async {
    try {
      emit(OrdersLoadInProcess());
      final orderParams = OrderParamsEntity(
          orderType: event.orderType,
          orderStatus: event.orderStatus,
          page: event.initPage,
          size: event.initSize);
      final orderList = await _ordersUseCase.getOrderListByStatus(orderParams);
      await Future.delayed(Duration(seconds: 1));
      emit(OrderLoadSuccess(
          orderList: orderList,
          orderType: event.orderType,
          orderStatus: event.orderStatus,
          page: event.initPage,
          size: event.initSize));
    } catch (e) {
      emit(OrderLoadFailure());
    }
  }

  FutureOr<void> _onOrderLoadMoreInformation(
      OrderLoadMoreInformation event, Emitter<OrdersState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        await Future.delayed(Duration(milliseconds: 1000));
        final orderParams = OrderParamsEntity(
            orderType: currentState.orderType,
            orderStatus: currentState.orderStatus,
            page: currentState.page + 1,
            size: currentState.size);
        final orderList =
            await _ordersUseCase.getOrderListByStatus(orderParams);
        if (orderList.isNotEmpty) {
          emit(currentState.copyWith(
              orderList: List.from(currentState.orderList)..addAll(orderList),
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

  FutureOr<void> _onOrderRefreshInformation(
      OrderRefreshInformation event, Emitter<OrdersState> emit) async {
    try {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        final orderParams = OrderParamsEntity(
            orderType: currentState.orderType,
            orderStatus: currentState.orderStatus,
            page: event.initPage,
            size: event.initSize);
        final orderList =
            await _ordersUseCase.getOrderListByStatus(orderParams);
        emit(currentState.copyWith(
            orderList: orderList,
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
