import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/topping_model.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  @override
  final List<ToppingModel>? toppings;

  ProductModel(
      {required String? id,
      required String? name,
      required int? quantity,
      required String? size,
      required double? price,
      required this.toppings,
      required String? note})
      : super(
            id: id,
            name: name,
            quantity: quantity,
            size: size,
            price: price,
            toppings: toppings,
            note: note);

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => toJson();
}
