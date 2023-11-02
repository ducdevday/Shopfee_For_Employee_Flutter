import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';

part 'event_log_model.g.dart';

@JsonSerializable()
class EventLogModel extends EventLogEntity {
  EventLogModel({
    required super.orderStatus,
    required super.time,
    required super.description,
    required super.makerByEmployee,
  });

  factory EventLogModel.fromJson(Map<String, dynamic> json) =>
      _$EventLogModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventLogModelToJson(this);

  factory EventLogModel.fromEntity(EventLogEntity eventLogEntity) =>
      EventLogModel(
          orderStatus: eventLogEntity.orderStatus,
          time: eventLogEntity.time,
          description: eventLogEntity.description,
          makerByEmployee: eventLogEntity.makerByEmployee);
}
