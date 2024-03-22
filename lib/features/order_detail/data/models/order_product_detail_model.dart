import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/topping_model.dart';

part "order_product_detail_model.g.dart";

@JsonSerializable()
class OrderProductDetailModel {
  int? quantity;
  String? size;
  double? price;
  @JsonKey(name: "toppingList")
  List<ToppingModel>? toppings;
  String? note;

  OrderProductDetailModel({
    this.quantity,
    this.size,
    this.price,
    this.toppings,
    this.note,
  });

  factory OrderProductDetailModel.fromJson(Map<String, dynamic> json) {
    return _$OrderProductDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderProductDetailModelToJson(this);
  }
}
