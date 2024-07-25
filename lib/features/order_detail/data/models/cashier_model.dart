
import 'package:json_annotation/json_annotation.dart';

part 'cashier_model.g.dart';

@JsonSerializable()
class CashierModel{
  final String id;
  @JsonKey(name: "fullName")
  final String name;

  const CashierModel({
    required this.id,
    required this.name,
  });

  factory CashierModel.fromJson(Map<String, dynamic> json) {
    return _$CashierModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CashierModelToJson(this);
  }
}