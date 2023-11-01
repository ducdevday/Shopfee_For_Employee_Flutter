import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';


class ShippingOrderService extends BaseService{
  Future<Response> getOrderListByStatus(OrderType type, OrderStatus status) async{
      final response = await dio.get("${BaseService.orderPath}/${type.name}/status/${status.name}");
      return response;
  }
}