import 'package:dartz/dartz.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';

abstract class OrderDetailRepository {
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail(String orderId);
}