import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/branch_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_product_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/receiver_information_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/transaction_entity.dart';
import 'package:shopfeeforemployee/features/pos/domain/entities/order_item_entity.dart';

class OrderBillEntity {
  String id;
  String note;
  num totalPayment;
  num shippingFee;
  num totalItemPrice;
  OrderType orderType;
  ReceiverInformationEntity receiverInformation;
  DateTime createdAt;
  List<OrderItemEntity> itemList;
  double orderDiscount;
  double shippingDiscount;
  TransactionEntity transaction;
  BranchEntity branch;
  int coin;

  OrderBillEntity({
    required this.id,
    required this.note,
    required this.totalPayment,
    required this.shippingFee,
    required this.totalItemPrice,
    required this.orderType,
    required this.receiverInformation,
    required this.createdAt,
    required this.itemList,
    required this.orderDiscount,
    required this.shippingDiscount,
    required this.transaction,
    required this.branch,
    required this.coin,
  });

  factory OrderBillEntity.fromOrderDetailEntity(OrderDetailEntity orderDetail) {
    List<OrderItemEntity> boughtList = [];
    for (var orderProduct in orderDetail.itemList!) {
      if (orderProduct.itemDetailList != null &&
          orderProduct.itemDetailList!.isNotEmpty) {
        for (var itemDetail in orderProduct.itemDetailList!) {
          boughtList.add(
            OrderItemEntity(
              productId: orderProduct.productId ?? "",
              name: orderProduct.name ?? "",
              itemDetail: itemDetail,
            ),
          );
        }
      }
    }
    List<OrderItemEntity> giftList = [];
    if (orderDetail.discountInformation != null &&
        orderDetail.discountInformation!.productGiftList != null &&
        orderDetail.discountInformation!.productGiftList!.isNotEmpty) {
      for (var giftProduct
          in orderDetail.discountInformation!.productGiftList!) {
        giftList.add(OrderItemEntity(
            productId: giftProduct.id ?? "",
            name: giftProduct.name ?? "",
            itemDetail: OrderProductDetailEntity(
              quantity: giftProduct.quantity,
              size: giftProduct.size,
              price: 0,
              productDiscount: 0,
              note: "",
            )));
      }
    }

    List<OrderItemEntity> itemList = [];
    itemList.addAll(boughtList);
    itemList.addAll(giftList);

    return OrderBillEntity(
      id: orderDetail.id ?? "",
      note: orderDetail.note ?? "",
      totalPayment: orderDetail.totalPayment ?? 0,
      shippingFee: orderDetail.shippingFee ?? 0,
      totalItemPrice: orderDetail.totalItemPrice ?? 0,
      orderType: orderDetail.orderType!,
      receiverInformation: orderDetail.receiverInformation!,
      createdAt: orderDetail.createdAt!,
      itemList: itemList,
      orderDiscount: orderDetail.discountInformation?.orderDiscount ?? 0,
      shippingDiscount: orderDetail.discountInformation?.shippingDiscount ?? 0,
      transaction: orderDetail.transaction!,
      branch: orderDetail.branch!,
      coin: orderDetail.coin ?? 0,
    );
  }
}
