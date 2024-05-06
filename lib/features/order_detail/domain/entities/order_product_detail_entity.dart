import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_product_detail_model.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/topping_entity.dart';

class OrderProductDetailEntity {
  int? quantity;
  String? size;
  double? price;
  double? productDiscount;
  List<ToppingEntity>? toppings;
  String? note;

  OrderProductDetailEntity({
    this.quantity,
    this.size,
    this.price,
    this.productDiscount,
    this.toppings,
    this.note,
  });

  double get total =>
      quantity! * price! +
      quantity! *
          (toppings == null
              ? 0
              : toppings!.fold(0, (total, current) => total + current.price));

  double get totalAfterDiscount =>
      quantity! * (price! - productDiscount!) +
      quantity! *
          (toppings == null
              ? 0
              : toppings!.fold(0, (total, current) => total + current.price));

  String get toppingOrderString {
    List<String> results = [];
    toppings?.map((t) => t.name).forEach((name) {
      results.add(name);
    });
    return results.join(", ");
  }

  factory OrderProductDetailEntity.fromModel(OrderProductDetailModel model) {
    return OrderProductDetailEntity(
      quantity: model.quantity,
      size: model.size,
      price: model.price,
      productDiscount: model.productDiscount,
      toppings: model.toppings?.map((e) => ToppingEntity.fromModel(e)).toList(),
      note: model.note,
    );
  }
}
