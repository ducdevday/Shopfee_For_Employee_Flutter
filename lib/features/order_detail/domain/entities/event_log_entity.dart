import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/event_log_model.dart';

class EventLogEntity {
  final OrderStatus? orderStatus;
  final DateTime? time;
  final String? description;
  final bool? makerByEmployee;

  const EventLogEntity({
    required this.orderStatus,
    this.time,
    required this.description,
    this.makerByEmployee,
  });

  factory EventLogEntity.fromModel(EventLogModel model) {
    return EventLogEntity(
        orderStatus: model.orderStatus,
        time: model.time,
        description: model.description,
        makerByEmployee: model.makerByEmployee);
  }
}
