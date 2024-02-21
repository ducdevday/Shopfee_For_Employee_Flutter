part of order_detail;

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderDetailUseCase _orderDetailUseCase;

  OrderDetailBloc(this._orderDetailUseCase) : super(OrderDetailInitial()) {
    on<LoadOrderDetail>(_onLoadOrderDetail);
    on<AddEventLog>(_onAddEventLogs);
    on<ChooseReasonCancel>(_onChooseReasonCancel);
  }

  FutureOr<void> _onLoadOrderDetail(
      LoadOrderDetail event, Emitter<OrderDetailState> emit) async {
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

  FutureOr<void> _onAddEventLogs(
      AddEventLog event, Emitter<OrderDetailState> emit) async {
    if (state is OrderDetailLoadSuccess) {
      final currentState = state as OrderDetailLoadSuccess;
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final fcmToken = await _orderDetailUseCase
          .getFCMToken(currentState.orderDetail.userId!);
      await _orderDetailUseCase.addEventLog(event.orderId, event.eventLog);
      emit(currentState.copyWith(
          eventLogs: List.from(currentState.eventLogs)..add(event.eventLog)));

      await _orderDetailUseCase.sendOrderMessage(
          event.eventLog.orderStatus!, event.orderId, fcmToken);
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
  }

  FutureOr<void> _onChooseReasonCancel(
      ChooseReasonCancel event, Emitter<OrderDetailState> emit) {
    if (state is OrderDetailLoadSuccess) {
      final currentState = state as OrderDetailLoadSuccess;
      emit(currentState.copyWith(reasonCancel: event.reasonCancel));
    }
  }
}
