import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';

part 'order_information_model.g.dart';

@JsonSerializable()
class OrderInformationModel {
  final String id;
  final num total;
  final String customerName;
  final String phoneNumber;
  final String productName;
  final int productQuantity;
  @JsonKey(name: "productThumbnailUrl")
  final String thumbnailUrl;
  final OrderStatus statusLastEvent;
  final DateTime timeLastEvent;
  final DateTime? receiveTime;

  const OrderInformationModel(
      {required this.id,
      required this.total,
      required this.customerName,
      required this.phoneNumber,
      required this.productName,
      required this.productQuantity,
      required this.thumbnailUrl,
      required this.statusLastEvent,
      required this.timeLastEvent,
      this.receiveTime});

  factory OrderInformationModel.fromJson(Map<String, dynamic> json) =>
      _$OrderInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderInformationModelToJson(this);
}
