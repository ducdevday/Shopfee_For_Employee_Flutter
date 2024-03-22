import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_product_detail_model.dart';

part 'order_product_model.g.dart';

@JsonSerializable()
class OrderProductModel {
  String? productId;
  String? name;
  List<OrderProductDetailModel>? itemDetailList;

  OrderProductModel({
    this.productId,
    this.name,
    this.itemDetailList,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return _$OrderProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderProductModelToJson(this);
  }
}
