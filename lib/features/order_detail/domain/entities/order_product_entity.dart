import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_product_model.dart';
import 'package:shopfeeforemployee/features/orders/data/models/order_params_model.dart';

import 'order_product_detail_entity.dart';

class OrderProductEntity {
  String? productId;
  String? name;
  List<OrderProductDetailEntity>? itemDetailList;

  OrderProductEntity({
    this.productId,
    this.name,
    this.itemDetailList,
  });

  factory OrderProductEntity.fromModel(OrderProductModel model) {
    return OrderProductEntity(
      productId: model.productId,
      name: model.name,
      itemDetailList: model.itemDetailList
          ?.map((e) => OrderProductDetailEntity.fromModel(e))
          .toList(),
    );
  }
}
