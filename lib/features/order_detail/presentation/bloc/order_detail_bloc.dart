part of order_detail;

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderDetailUseCase _orderDetailUseCase;

  OrderDetailBloc(this._orderDetailUseCase) : super(OrderDetailInitial()) {
    on<OrderDetailLoadInformation>(_onOrderDetailLoadInformation);
    on<OrderDetailDoAction>(_onOrderDetailDoAction);
    on<OrderDetailChooseReasonCancel>(_onOrderDetailChooseReasonCancel);
  }

  FutureOr<void> _onOrderDetailLoadInformation(
      OrderDetailLoadInformation event, Emitter<OrderDetailState> emit) async {
    try {
      emit(OrderDetailLoadInProcess());
      final response = await Future.wait([
        _orderDetailUseCase.getOrderDetail(event.orderId),
        _orderDetailUseCase.getEventLogs(event.orderId)
      ]);
      final OrderDetailEntity orderDetail = response[0] as OrderDetailEntity;
      final List<EventLogEntity> eventLogs =
          response[1] as List<EventLogEntity>;
      emit(OrderDetailLoadSuccess(
          orderDetail: orderDetail,
          eventLogs: eventLogs,
          haveChanged: event.haveChanged));
    } catch (e) {
      emit(OrderDetailLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onOrderDetailChooseReasonCancel(
      OrderDetailChooseReasonCancel event, Emitter<OrderDetailState> emit) {
    if (state is OrderDetailLoadSuccess) {
      final currentState = state as OrderDetailLoadSuccess;
      emit(currentState.copyWith(reasonCancel: event.reasonCancel));
    }
  }

  FutureOr<void> _onOrderDetailDoAction(
      OrderDetailDoAction event, Emitter<OrderDetailState> emit) async {
    try {
      if (state is OrderDetailLoadSuccess) {
        final currentState = state as OrderDetailLoadSuccess;
        EasyLoading.show();
        switch (event.orderEventType) {
          case OrderEventType.ORDER_REFUSE:
            await _orderDetailUseCase.refuseOrder(
                event.orderId, event.description!);
            break;
          case OrderEventType.ORDER_ACCEPT:
            await _orderDetailUseCase.acceptOrder(event.orderId);
            break;
          case OrderEventType.CANCEL_REQUEST_REFUSE:
            await _orderDetailUseCase.refuseRequestCancel(event.orderId);
            break;
          case OrderEventType.CANCEL_REQUEST_ACCEPT:
            await _orderDetailUseCase.acceptRequestCancel(event.orderId);
            break;
          case OrderEventType.READY_SHIPPING:
            await _orderDetailUseCase.preparedOrder(event.orderId);
            break;
          case OrderEventType.START_SHIPPING:
            await _orderDetailUseCase.deliveryOrder(event.orderId);
            break;
          case OrderEventType.ORDER_FULFILL:
            await _orderDetailUseCase.fulfillOrder(event.orderId);
            break;
          case OrderEventType.ORDER_BOOM:
            await _orderDetailUseCase.markBoomOrder(event.orderId);
            break;
          default:
            break;
        }
        EasyLoading.dismiss();
        //TODO: Reload Page
        add(OrderDetailLoadInformation(
            orderId: event.orderId, haveChanged: true));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
