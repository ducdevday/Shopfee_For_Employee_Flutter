import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/topping_model.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  String? id;
  String? name;
  int? quantity;
  String? size;
  double? price;
  List<ToppingModel>? toppings;
  String? note;

  ProductModel({
    this.id,
    this.name,
    this.quantity,
    this.size,
    this.price,
    this.toppings,
    this.note,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => toJson();
}
