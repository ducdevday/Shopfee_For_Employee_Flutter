part of shipping_order;

class ShippingOrderBloc extends Bloc<ShippingOrderEvent, ShippingOrderState> {
  final ShippingOrderUseCase _shippingOrderUseCase;

  ShippingOrderBloc(this._shippingOrderUseCase)
      : super(ShippingOrderInitial()) {
    on<LoadShippingOrder>(_onLoadShippingOrder);
    on<LoadMoreShippingOrder>(_onLoadMoreShippingOrder);
  }

  FutureOr<void> _onLoadShippingOrder(
      LoadShippingOrder event, Emitter<ShippingOrderState> emit) async {
    try {
      emit(ShippingOrderLoading());
      int page = 1;
      int size = 5;
      final orderList = await _shippingOrderUseCase.getOrderListByStatus(
          OrderType.SHIPPING, event.orderStatus, page, size);

      emit(ShippingOrderLoaded(orderList: orderList, page: page, size: size));
    } catch (e) {
      emit(ShippingOrderError());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onLoadMoreShippingOrder(
      LoadMoreShippingOrder event, Emitter<ShippingOrderState> emit) async {
    try {
      if (state is ShippingOrderLoaded) {
        final currentState = state as ShippingOrderLoaded;
        emit(currentState.copyWith(isLoadMore: true));
        await Future.delayed(Duration(milliseconds: 1000));
        final orderList = await _shippingOrderUseCase.getOrderListByStatus(
            OrderType.SHIPPING,
            event.orderStatus,
            currentState.page + 1,
            currentState.size);
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
      emit(ShippingOrderError());
      ExceptionUtil.handle(e);
    }
  }
}
