

import 'package:shopfeeforemployee/core/common/enum/order_event_type.dart';

class OrderActionEntity{
  final OrderEventType orderEvent;
  final String? description;

  const OrderActionEntity({
    required this.orderEvent,
    this.description,
  });
}