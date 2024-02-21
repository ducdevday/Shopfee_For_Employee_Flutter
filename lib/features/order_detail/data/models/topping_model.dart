import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/topping_entity.dart';

part 'topping_model.g.dart';

@JsonSerializable()
class ToppingModel {
  final String name;
  final double price;

  const ToppingModel({
    required this.name,
    required this.price,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) =>
      _$ToppingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingModelToJson(this);
}
