part of refund;

class RefundBloc extends Bloc<RefundEvent, RefundState> {
  final RefundUseCase _refundUseCase;

  RefundBloc(this._refundUseCase) : super(RefundInitial()) {
    on<RefundLoadDetail>(_onRefundLoadDetail);
    on<RefundAcceptButtonPressed>(_onRefundAcceptButtonPressed);
    on<RefundRejectButtonPressed>(_onRefundRejectButtonPressed);
  }

  FutureOr<void> _onRefundLoadDetail(
      RefundLoadDetail event, Emitter<RefundState> emit) async {
    try {
      EasyLoading.show();
      final refundDetail = await _refundUseCase.getRefundDetail(event.orderId);
      EasyLoading.dismiss();
      emit(RefundLoadDetailSuccess(refundDetail: refundDetail));
    } catch (e) {
      emit(RefundLoadDetailFailure());
    }
  }

  FutureOr<void> _onRefundAcceptButtonPressed(
      RefundAcceptButtonPressed event, Emitter<RefundState> emit) async {
    try {
      EasyLoading.show();
      await _refundUseCase.acceptRequestRefund(event.orderId);
      EasyLoading.dismiss();
      add(RefundLoadDetail(orderId: event.orderId));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onRefundRejectButtonPressed(
      RefundRejectButtonPressed event, Emitter<RefundState> emit) async {
    try {
      EasyLoading.show();
      await _refundUseCase.rejectRequestRefund(event.orderId);
      EasyLoading.dismiss();
      add(RefundLoadDetail(orderId: event.orderId));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
