import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel extends HistoryEntity {
  HistoryModel(
      {required super.id,
      required super.total,
      required super.customerName,
      required super.phoneNumber,
      required super.productName,
      required super.productQuantity,
      required super.thumbnailUrl,
      required super.orderType,
      required super.statusLastEvent,
      required super.timeLastEvent});

  factory HistoryModel.fromJson(Map<String, dynamic> json) => _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
