part of refund;

abstract class RefundState extends Equatable {
  const RefundState();
}

class RefundInitial extends RefundState {
  @override
  List<Object> get props => [];
}

class RefundLoadDetailInProcess extends RefundState {
  @override
  List<Object> get props => [];
}

class RefundLoadDetailSuccess extends RefundState {
  final RefundDetailEntity refundDetail;

  const RefundLoadDetailSuccess({
    required this.refundDetail,
  });

  @override
  List<Object> get props => [refundDetail];
}

class RefundLoadDetailFailure extends RefundState {
  @override
  List<Object> get props => [];
}
