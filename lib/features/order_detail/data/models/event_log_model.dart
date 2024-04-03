import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';

part 'event_log_model.g.dart';

@JsonSerializable()
class EventLogModel{
  final OrderStatus? orderStatus;
  @JsonKey(name: "createdAt")
  final DateTime? time;
  final String? description;
  @JsonKey(name: "employee")
  final bool? makerByEmployee;

  const EventLogModel({
    this.orderStatus,
    this.time,
    this.description,
    this.makerByEmployee,
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
