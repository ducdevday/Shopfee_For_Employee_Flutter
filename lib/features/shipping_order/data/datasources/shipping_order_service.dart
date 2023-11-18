import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';


class ShippingOrderService extends BaseService{
  Future<Response> getOrderListByStatus(OrderType type, OrderStatus status, {required int page, required int size}) async{
    Map<String, dynamic> query = {"page": page, "size": size};
      final response = await dio.get("${BaseService.orderPath}/${type.name}/status/${status.name}", queryParameters: query);
      return response;
  }
}