import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  final String id;
  final double total;
  final String customerName;
  final String phoneNumber;
  final String productName;
  final int productQuantity;
  final String thumbnailUrl;
  final OrderType orderType;
  final OrderStatus statusLastEvent;
  final DateTime timeLastEvent;

  HistoryModel(
      {required this.id,
      required this.total,
      required this.customerName,
      required this.phoneNumber,
      required this.productName,
      required this.productQuantity,
      required this.thumbnailUrl,
      required this.orderType,
      required this.statusLastEvent,
      required this.timeLastEvent});

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
