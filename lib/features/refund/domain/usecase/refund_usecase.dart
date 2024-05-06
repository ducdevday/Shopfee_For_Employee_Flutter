import 'package:shopfeeforemployee/core/common/enum/refund_request_status.dart';
import 'package:shopfeeforemployee/core/common/enum/refund_status.dart';
import 'package:shopfeeforemployee/features/refund/domain/entities/refund_detail_model.dart';
import 'package:shopfeeforemployee/features/refund/domain/repositories/refund_repository.dart';

abstract class RefundUseCase {
  Future<RefundDetailEntity> getRefundDetail(String orderId);

  Future<void> rejectRequestRefund(orderId);

  Future<void> acceptRequestRefund(orderId);
}

class RefundUseCaseImpl extends RefundUseCase {
  final RefundRepository _refundRepository;

  RefundUseCaseImpl(this._refundRepository);

  @override
  Future<RefundDetailEntity> getRefundDetail(String orderId) async {
    return await _refundRepository.getRefundDetail(orderId);
  }

  @override
  Future<void> acceptRequestRefund(orderId) async {
    return await _refundRepository.doActionRefund(
        orderId, RefundStatus.ACCEPTED);
  }

  @override
  Future<void> rejectRequestRefund(orderId) async {
    return await _refundRepository.doActionRefund(
        orderId, RefundStatus.REFUSED);
  }
}
