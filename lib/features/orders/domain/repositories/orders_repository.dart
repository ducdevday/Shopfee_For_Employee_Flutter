import 'package:shopfeeforemployee/features/orders/domain/entities/order_information_entity.dart';
import 'package:shopfeeforemployee/features/orders/domain/entities/order_params_entity.dart';


abstract class OrdersRepository {
  Future<List<OrderInformationEntity>> getOrderListByStatus(OrderParamsEntity params);
}