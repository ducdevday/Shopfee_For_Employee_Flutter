import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/features/orders/data/models/order_params_model.dart';


class OrdersService{
  Future<Response> getOrderListByStatus(OrderParamsModel params) async{
      final response = await DioService.instance.get("${DioService.orderPath}/queue", queryParameters: params.toJson());
      return response;
  }
}