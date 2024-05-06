import 'package:shopfeeforemployee/core/common/enum/refund_request_status.dart';
import 'package:shopfeeforemployee/core/common/enum/refund_status.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/features/refund/data/datasources/refund_service.dart';
import 'package:shopfeeforemployee/features/refund/data/models/refund_detail_model.dart';
import 'package:shopfeeforemployee/features/refund/domain/entities/refund_detail_model.dart';
import 'package:shopfeeforemployee/features/refund/domain/repositories/refund_repository.dart';

class RefundRepositoryImpl implements RefundRepository {
  final RefundService _refundService;

  RefundRepositoryImpl(this._refundService);

  @override
  Future<RefundDetailEntity> getRefundDetail(String orderId) async {
    final response = await _refundService.getRefundDetail(orderId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final refundDetailModel = RefundDetailModel.fromJson(result.data!);
    final refundDetailEntity = RefundDetailEntity.fromModel(refundDetailModel);
    return refundDetailEntity;
  }

  @override
  Future<void> doActionRefund(String orderId, RefundStatus refundStatus) async {
    final response = await _refundService.doActionRefund(orderId, refundStatus);
  }
}
