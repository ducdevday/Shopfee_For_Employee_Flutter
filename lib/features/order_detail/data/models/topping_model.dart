import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/topping_entity.dart';

part 'topping_model.g.dart';

@JsonSerializable()
class ToppingModel extends ToppingEntity{
  ToppingModel({required super.name, required super.price});

  factory ToppingModel.fromJson(Map<String, dynamic> json) => _$ToppingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingModelToJson(this);
}
