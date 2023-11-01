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

}
