part of orders;

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersUseCase _ordersUseCase;

  OrdersBloc(this._ordersUseCase) : super(OrdersInitial()) {
    on<OrderLoadInformation>(_onOrderLoadInformation);
    on<OrderLoadMoreInformation>(_onOrderLoadMoreInformation);
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
      emit(ShippingOrderLoadSuccess(
          orderList: orderList, page: event.initPage, size: event.initSize));
    } catch (e) {
      emit(ShippingOrderLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onOrderLoadMoreInformation(
      OrderLoadMoreInformation event, Emitter<OrdersState> emit) async {
    try {
      if (state is ShippingOrderLoadSuccess) {
        final currentState = state as ShippingOrderLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        await Future.delayed(Duration(milliseconds: 1000));
        final orderParams = OrderParamsEntity(
            orderType: event.orderType,
            orderStatus: event.orderStatus,
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
      emit(ShippingOrderLoadFailure());
      ExceptionUtil.handle(e);
    }
  }
}
