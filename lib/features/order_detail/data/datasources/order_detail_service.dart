import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';


class OrderDetailService extends BaseService{
  Future<Response> getOrderDetail(String orderId) async{
      final response = await dio.get("${BaseService.orderPath}/details/$orderId");
      return response;
  }
}