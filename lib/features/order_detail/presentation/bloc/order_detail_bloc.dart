part of order_detail;

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderDetailUseCase _orderDetailUseCase;

  OrderDetailBloc(this._orderDetailUseCase) : super(OrderDetailInitial()) {
    on<OrderDetailLoadInformation>(_onOrderDetailLoadInformation);
    on<OrderDetailRefreshInformation>(_onOrderDetailRefreshInformation);
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

  FutureOr<void> _onOrderDetailRefreshInformation(
      OrderDetailRefreshInformation event,
      Emitter<OrderDetailState> emit) async {
    try {
      if (state is OrderDetailLoadSuccess) {
        final currentState = state as OrderDetailLoadSuccess;
        EasyLoading.show();
        final response = await Future.wait([
          _orderDetailUseCase.getOrderDetail(event.orderId),
          _orderDetailUseCase.getEventLogs(event.orderId)
        ]);
        EasyLoading.dismiss();
        final OrderDetailEntity orderDetail = response[0] as OrderDetailEntity;
        final List<EventLogEntity> eventLogs =
            response[1] as List<EventLogEntity>;
        emit(OrderDetailLoadSuccess(
            orderDetail: orderDetail,
            eventLogs: eventLogs,
            haveChanged: currentState.haveChanged));
      }
    } catch (e) {
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
          case OrderEventType.EMPLOYEE_ORDER_REFUSE:
            await _orderDetailUseCase.refuseOrder(
                currentState.orderDetail.receiverInformation!.userId!,
                event.orderId,
                event.description!);
            break;
          case OrderEventType.ACCEPT_ORDER:
            await _orderDetailUseCase.acceptOrder(
                currentState.orderDetail.receiverInformation!.userId!,
                event.orderId);
            break;
          case OrderEventType.REFUSE_ORDER_CANCELLATION:
            await _orderDetailUseCase.refuseRequestCancel(
                currentState.orderDetail.receiverInformation!.userId!,
                event.orderId);
            break;
          case OrderEventType.ACCEPT_ORDER_CANCELLATION:
            await _orderDetailUseCase.acceptRequestCancel(
                currentState.orderDetail.receiverInformation!.userId!,
                event.orderId);
            break;
          case OrderEventType.PREPARED:
            await _orderDetailUseCase.preparedOrder(
                currentState.orderDetail.receiverInformation!.userId!,
                event.orderId);
            break;
          case OrderEventType.START_SHIPPING:
            await _orderDetailUseCase.deliveryOrder(
                currentState.orderDetail.receiverInformation!.userId!,
                event.orderId);
            break;
          case OrderEventType.FULFILL:
            await _orderDetailUseCase.fulfillOrder(
                currentState.orderDetail.receiverInformation!.userId!,
                event.orderId);
            break;
          case OrderEventType.BOOM:
            await _orderDetailUseCase.markBoomOrder(
                currentState.orderDetail.receiverInformation!.userId!,
                event.orderId);
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

  Future<String> getCancelRequestReason() async {
    try {
      if(state is OrderDetailLoadSuccess){
        final currentState = state as OrderDetailLoadSuccess;
        final cancelRequest = currentState.eventLogs.firstWhere((e) => e.orderStatus == OrderStatus.CANCELLATION_REQUEST);
        if(cancelRequest != null){
          return cancelRequest.note ?? "";
        }
        return "";
      }
      return "";
    } catch (e) {
      ExceptionUtil.handle(e);
      return "";
    }
  }
}
