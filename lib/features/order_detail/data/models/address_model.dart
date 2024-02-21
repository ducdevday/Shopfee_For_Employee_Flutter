import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/adress_entity.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String? details;
  final String? note;
  final String? recipientName;
  final String? phoneNumber;

  const AddressModel({
    this.details,
    this.note,
    this.recipientName,
    this.phoneNumber,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
