

import 'package:shopfeeforemployee/features/order_detail/data/models/topping_model.dart';

class ToppingEntity {
  final String name;
  final double price;

  ToppingEntity({required this.name, required this.price});

  factory ToppingEntity.fromModel(ToppingModel model){
    return ToppingEntity(name: model.name, price: model.price);
  }

}
