import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/enum/refund_request_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/discount_information_model.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_product_model.dart';

import 'branch_model.dart';
import 'receiver_information_model.dart';
import 'transaction_model.dart';

part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel {
  String? id;
  String? note;
  num? totalPayment;
  num? shippingFee;
  num? totalItemPrice;
  OrderType? orderType;
  ReceiverInformationModel? receiverInformation;
  DateTime? createdAt;
  List<OrderProductModel>? itemList;
  @JsonKey(name: "rewardInformation")
  DiscountInformationModel? discountInformation;
  TransactionModel? transaction;
  BranchModel? branch;
  int? coin;
  @JsonKey(name: "refundStatus")
  RefundRequestStatus? refundRequestStatus;

  OrderDetailModel({
    this.id,
    this.note,
    this.totalPayment,
    this.shippingFee,
    this.totalItemPrice,
    this.orderType,
    this.receiverInformation,
    this.createdAt,
    this.itemList,
    this.transaction,
    this.branch,
    this.coin,
    this.refundRequestStatus
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}
