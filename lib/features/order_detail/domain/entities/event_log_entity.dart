import 'package:shopfeeforemployee/core/common/enum/actor_type.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/event_log_model.dart';

class EventLogEntity {
  final OrderStatus? orderStatus;
  final DateTime? time;
  final String? description;
  final String? note;
  final ActorType? actor;

  const EventLogEntity({
    this.orderStatus,
    this.time,
    this.description,
    this.note,
    this.actor,
  });

  factory EventLogEntity.fromModel(EventLogModel model) {
    return EventLogEntity(
        orderStatus: model.orderStatus,
        time: model.time,
        description: model.description,
        note: model.note,
        actor: model.actor);
  }
}
