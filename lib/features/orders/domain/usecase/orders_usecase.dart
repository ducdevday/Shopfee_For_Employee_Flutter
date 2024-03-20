
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/orders/domain/entities/order_information_entity.dart';
import 'package:shopfeeforemployee/features/orders/domain/entities/order_params_entity.dart';
import 'package:shopfeeforemployee/features/orders/domain/repositories/orders_repository.dart';

abstract class OrdersUseCase{
  Future<List<OrderInformationEntity>> getOrderListByStatus(OrderParamsEntity params);
}

class OrdersUseCaseImpl extends OrdersUseCase{
  final OrdersRepository _ordersRepository;

  OrdersUseCaseImpl(this._ordersRepository);

  @override
  Future<List<OrderInformationEntity>> getOrderListByStatus(OrderParamsEntity params) async{
      return await _ordersRepository.getOrderListByStatus(params);
  }
}