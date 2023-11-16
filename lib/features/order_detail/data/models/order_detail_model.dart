import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';

import 'address_model.dart';
import 'product_model.dart';
import 'review_model.dart';
import 'transaction_model.dart';

part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel extends OrderDetailEntity {
  @override
  final AddressModel? address;
  @override
  final List<ProductModel>? products;
  @override
  final TransactionModel? transaction;
  @override
  final ReviewModel? review;

  OrderDetailModel({
    required String? id,
    required String? note,
    required double? total,
    required OrderType? orderType,
    required this.address,
    required DateTime? createdAt,
    required this.products,
    required this.transaction,
    required this.review,
    required String? userId,
  }) : super(
            id: id,
            note: note,
            total: total,
            orderType: orderType,
            address: address,
            createdAt: createdAt,
            products: products,
            transaction: transaction,
            review: review,
            userId: userId);

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}
