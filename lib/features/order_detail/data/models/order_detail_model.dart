import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';

import 'address_model.dart';
import 'product_model.dart';
import 'review_model.dart';
import 'transaction_model.dart';

part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel {
  String? id;
  String? note;
  double? total;
  OrderType? orderType;
  AddressModel? address;
  DateTime? createdAt;
  List<ProductModel>? products;
  TransactionModel? transaction;
  ReviewModel? review;
  String? userId;

  OrderDetailModel({
    this.id,
    this.note,
    this.total,
    this.orderType,
    this.address,
    this.createdAt,
    this.products,
    this.transaction,
    this.review,
    this.userId,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}
