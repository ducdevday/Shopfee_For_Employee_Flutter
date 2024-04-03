part of order_detail;

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderDetailUseCase _orderDetailUseCase;

  OrderDetailBloc(this._orderDetailUseCase) : super(OrderDetailInitial()) {
    on<OrderDetailLoadInformation>(_onOrderDetailLoadInformation);
    on<OrderDetailAddEventLog>(_onOrderDetailAddEventLog);
    on<OrderDetailChooseReasonCancel>(_onOrderDetailChooseReasonCancel);
    on<OrderDetailAcceptRequestCancel>(_onOrderDetailAcceptRequestCancel);
    on<OrderDetailRefuseRequestCancel>(_onOrderDetailRefuseRequestCancel);
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
          orderDetail: orderDetail, eventLogs: eventLogs));
    } catch (e) {
      emit(OrderDetailLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onOrderDetailAddEventLog(
      OrderDetailAddEventLog event, Emitter<OrderDetailState> emit) async {
    try {
      if (state is OrderDetailLoadSuccess) {
        final currentState = state as OrderDetailLoadSuccess;
        EasyLoading.show(maskType: EasyLoadingMaskType.black);

        // final fcmToken = await _orderDetailUseCase
        //     .getFCMToken(currentState.orderDetail.userId!);

        await _orderDetailUseCase.addEventLog(event.orderId, event.eventLog);

        //TODO: Reload Page
        add(OrderDetailLoadInformation(orderId: event.orderId));

        // await _orderDetailUseCase.sendOrderMessage(
        //     event.eventLog.orderStatus!, event.orderId, fcmToken);

        if (event.eventLog.orderStatus != OrderStatus.CANCELED) {
          EasyLoading.showSuccess("Success",
              duration: Duration(milliseconds: 2000));
        } else {
          EasyLoading.showSuccess("Canceled",
              duration: Duration(milliseconds: 2000));
        }
        if (event.eventLog.orderStatus == OrderStatus.SUCCEED &&
            currentState.orderDetail.transaction!.status ==
                PaymentStatus.UNPAID) {
          final responseTransaction = await _orderDetailUseCase
              .completeTransaction(currentState.orderDetail.transaction!.id!);
        }
        EasyLoading.dismiss();
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

  FutureOr<void> _onOrderDetailAcceptRequestCancel(
      OrderDetailAcceptRequestCancel event,
      Emitter<OrderDetailState> emit) async {
    try {
      EasyLoading.show();
      await _orderDetailUseCase.acceptRequestCancel(event.orderId);
      EasyLoading.dismiss();

      //TODO: Reload Page
      add(OrderDetailLoadInformation(orderId: event.orderId));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onOrderDetailRefuseRequestCancel(OrderDetailRefuseRequestCancel event, Emitter<OrderDetailState> emit) async {
    try {
      EasyLoading.show();
      await _orderDetailUseCase.refuseRequestCancel(event.orderId);
      EasyLoading.dismiss();

      //TODO: Reload Page
      add(OrderDetailLoadInformation(orderId: event.orderId));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
