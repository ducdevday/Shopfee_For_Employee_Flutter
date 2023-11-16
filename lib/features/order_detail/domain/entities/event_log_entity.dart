import 'package:shopfeeforemployee/core/common/models/order_status.dart';

class EventLogEntity{
  final OrderStatus orderStatus;
  final DateTime? time;
  final String? description;
  final bool? makerByEmployee;

  const EventLogEntity({
    required this.orderStatus,
    required this.time,
    required this.description,
    this.makerByEmployee,
  });
}