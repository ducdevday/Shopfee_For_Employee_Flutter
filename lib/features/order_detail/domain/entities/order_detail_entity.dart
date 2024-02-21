import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_detail_model.dart';
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

  factory OrderDetailEntity.fromModel(OrderDetailModel model){
    return OrderDetailEntity(id: model.id,
        note: model.note,
        total: model.total,
        orderType: model.orderType,
        address: model.address == null ? null : AddressEntity.fromModel(
            model.address!),
        createdAt: model.createdAt,
        products: model.products?.map((e) => ProductEntity.fromModel(e))
            .toList(),
        transaction: model.transaction == null ? null : TransactionEntity
            .fromModel(model.transaction!),
        review: model.review == null ? null : ReviewEntity.fromModel(
            model.review!),
        userId: model.userId);
  }

}