import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/core/common/models/result_list.dart';
import 'package:shopfeeforemployee/features/shipping_order/data/datasources/shipping_order_service.dart';
import 'package:shopfeeforemployee/features/shipping_order/data/models/shipping_order_model.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/repositories/shipping_order_repository.dart';

class ShippingOrderRepositoryImpl implements ShippingOrderRepository {
  final ShippingOrderService _shippingOrderService;

  ShippingOrderRepositoryImpl(this._shippingOrderService);

  @override
  Future<List<ShippingOrderEntity>> getOrderListByStatus(
      OrderType type, OrderStatus status, int page, int size) async {
    final response = await _shippingOrderService
        .getOrderListByStatus(type, status, page: page, size: size);
    final resultList = ResultList(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    List<ShippingOrderModel> orderModelList =
        resultList.data!.map((e) => ShippingOrderModel.fromJson(e)).toList();
    List<ShippingOrderEntity> orderEntityList =
        orderModelList.map((e) => ShippingOrderEntity.fromModel(e)).toList();
    return orderEntityList;
  }
}
