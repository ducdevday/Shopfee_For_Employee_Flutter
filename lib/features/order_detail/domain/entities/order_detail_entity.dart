import 'package:shopfeeforemployee/core/common/enum/refund_request_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_detail_model.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/discount_information_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/receiver_information_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/transaction_entity.dart';

import 'branch_entity.dart';
import 'order_product_entity.dart';

class OrderDetailEntity {
  String? id;
  String? note;
  num? totalPayment;
  num? shippingFee;
  num? totalItemPrice;
  OrderType? orderType;
  ReceiverInformationEntity? receiverInformation;
  DateTime? createdAt;
  List<OrderProductEntity>? itemList;
  DiscountInformationEntity? discountInformation;
  TransactionEntity? transaction;
  BranchEntity? branch;
  int? coin;
  RefundRequestStatus? refundRequestStatus;

  OrderDetailEntity({
    this.id,
    this.note,
    this.totalPayment,
    this.shippingFee,
    this.totalItemPrice,
    this.orderType,
    this.receiverInformation,
    this.createdAt,
    this.itemList,
    this.discountInformation,
    this.transaction,
    this.branch,
    this.coin,
    this.refundRequestStatus
  });

  factory OrderDetailEntity.fromModel(OrderDetailModel model) {
    return OrderDetailEntity(
        id: model.id,
        note: model.note,
        totalPayment: model.totalPayment,
        shippingFee: model.shippingFee,
        totalItemPrice: model.totalItemPrice,
        orderType: model.orderType,
        receiverInformation: model.receiverInformation == null
            ? null
            : ReceiverInformationEntity.fromModel(model.receiverInformation!),
        createdAt: model.createdAt,
        itemList: model.itemList
            ?.map((e) => OrderProductEntity.fromModel(e))
            .toList(),
        discountInformation: model.discountInformation == null
            ? null
            : DiscountInformationEntity.fromModel(model.discountInformation!),
        transaction: model.transaction == null
            ? null
            : TransactionEntity.fromModel(model.transaction!),
        branch: model.branch == null ? null : BranchEntity.fromModel(model.branch!),
        coin: model.coin,
        refundRequestStatus: model.refundRequestStatus
    );
  }

}