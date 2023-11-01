import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/adress_entity.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends AddressEntity {

  AddressModel({required super.details, required super.note, required super.recipientName, required super.phoneNumber});

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}