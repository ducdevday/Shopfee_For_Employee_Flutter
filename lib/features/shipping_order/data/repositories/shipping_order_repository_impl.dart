import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/core/common/models/result_list.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/shipping_order/data/datasources/shipping_order_service.dart';
import 'package:shopfeeforemployee/features/shipping_order/data/models/shipping_order_model.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/repositories/shipping_order_repository.dart';

class ShippingOrderRepositoryImpl implements ShippingOrderRepository {
  final ShippingOrderService _shippingOrderService;

  ShippingOrderRepositoryImpl(this._shippingOrderService);

  @override
  Future<Either<Failure, List<ShippingOrderModel>>> getOrderListByStatus(
      OrderType type, OrderStatus status) async {
    try {
      final response =
          await _shippingOrderService.getOrderListByStatus(type, status);
      final result = ResultList(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
      if (result.success == true) {
        List<ShippingOrderModel> orderList =
            result.data!.map((e) => ShippingOrderModel.fromJson(e)).toList();
        return Right(orderList);
      }
      return Left(UnknownFailure());
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          return Left(NetworkFailure());
        }
        return Left(UnknownFailure());
      }
      return Left(UnknownFailure());
    }
  }
}