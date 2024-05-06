import 'package:shopfeeforemployee/core/common/enum/refund_request_status.dart';
import 'package:shopfeeforemployee/core/common/enum/refund_status.dart';
import 'package:shopfeeforemployee/features/refund/domain/entities/refund_detail_model.dart';

abstract class RefundRepository {
  Future<RefundDetailEntity> getRefundDetail(String orderId);
  Future<void> doActionRefund(
      String orderId, RefundStatus requestStatus);
}
