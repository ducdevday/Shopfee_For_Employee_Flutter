import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/core/common/enum/refund_request_status.dart';
import 'package:shopfeeforemployee/core/common/enum/refund_status.dart';

class RefundService {
  Future<Response> getRefundDetail(String orderId) async {
    final response =
        await DioService.instance.get("${DioService.refundPath}/$orderId");
    return response;
  }

  Future<Response> doActionRefund(
      String orderId, RefundStatus refundStatus) async {
    final params = {"status": refundStatus.name};
    final response = await DioService.instance
        .patch("${DioService.refundPath}/$orderId", queryParameters: params);
    return response;
  }
}
