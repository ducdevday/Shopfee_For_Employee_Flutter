import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/common/models/result_list.dart';
import 'package:shopfeeforemployee/features/orders/data/datasources/orders_service.dart';
import 'package:shopfeeforemployee/features/orders/data/models/order_information_model.dart';
import 'package:shopfeeforemployee/features/orders/data/models/order_params_model.dart';
import 'package:shopfeeforemployee/features/orders/domain/entities/order_information_entity.dart';
import 'package:shopfeeforemployee/features/orders/domain/entities/order_params_entity.dart';
import 'package:shopfeeforemployee/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersService _ordersService;

  OrdersRepositoryImpl(this._ordersService);

  @override
  Future<List<OrderInformationEntity>> getOrderListByStatus(
      OrderParamsEntity params) async {
    final queryParams = OrderParamsModel.fromEntity(params);
    final response = await _ordersService.getOrderListByStatus(queryParams);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final orderJsonList = result.data!["orderList"] as List<dynamic>;
    List<OrderInformationModel> orderModelList =
        orderJsonList.map((e) => OrderInformationModel.fromJson(e)).toList();
    List<OrderInformationEntity> orderEntityList =
        orderModelList.map((e) => OrderInformationEntity.fromModel(e)).toList();
    return orderEntityList;
  }
}
