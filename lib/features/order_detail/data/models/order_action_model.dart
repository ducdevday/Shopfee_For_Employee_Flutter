
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_action_entity.dart';

part 'order_action_model.g.dart';

@JsonSerializable()
class OrderActionModel{
  @JsonKey(name: "event")
  final String orderEvent;
  @JsonKey(name: "note")
  final String? description;

  const OrderActionModel({
    required this.orderEvent,
    required this.description,
  });

  factory OrderActionModel.fromJson(Map<String, dynamic> json) {
    return _$OrderActionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderActionModelToJson(this);
  }

  factory OrderActionModel.fromEntity(OrderActionEntity entity) {
    return OrderActionModel(
      orderEvent: entity.orderEvent.name,
      description: entity.description,
    );
  }
//
}