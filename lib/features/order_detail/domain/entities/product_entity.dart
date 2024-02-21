import 'package:shopfeeforemployee/features/order_detail/data/models/product_model.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/topping_entity.dart';

class ProductEntity {
  String? id;
  String? name;
  int? quantity;
  String? size;
  double? price;
  List<ToppingEntity>? toppings;
  String? note;

  ProductEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.size,
    required this.price,
    required this.toppings,
    required this.note,
  });

  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
        id: model.id,
        name: model.name,
        quantity: model.quantity,
        size: model.size,
        price: model.price,
        toppings:
            model.toppings?.map((e) => ToppingEntity.fromModel(e)).toList(),
        note: model.note);
  }
}
