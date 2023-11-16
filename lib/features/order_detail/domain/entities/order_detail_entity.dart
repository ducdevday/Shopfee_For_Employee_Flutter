import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/adress_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/product_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/review_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/transaction_entity.dart';

class OrderDetailEntity {
  String? id;
  String? note;
  double? total;
  OrderType? orderType;
  AddressEntity? address;
  DateTime? createdAt;
  List<ProductEntity>? products;
  TransactionEntity? transaction;
  ReviewEntity? review;
  String? userId;
  OrderDetailEntity({
    required this.id,
    required this.note,
    required this.total,
    required this.orderType,
    required this.address,
    required this.createdAt,
    required this.products,
    required this.transaction,
    required this.review,
    required this.userId
  });
}