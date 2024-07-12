import 'package:shopfeeforemployee/core/common/enum/order_event_type.dart';

extension OrderEventExtension on OrderEventType {
  String getFormattedString() {
    switch (this) {
      case OrderEventType.EMPLOYEE_REFUSE:
        return "Cancel Order";
      case OrderEventType.ACCEPT_ORDER:
        return "Accept Order";
      case OrderEventType.REFUSE_ORDER_CANCELLATION:
        return "Refuse Request";
      case OrderEventType.ACCEPT_ORDER_CANCELLATION:
        return "Accept Request";
      case OrderEventType.PREPARED:
        return "Prepared Order";
      case OrderEventType.START_SHIPPING:
        return "Delivery";
      case OrderEventType.FULFILL:
        return "Finish";
      case OrderEventType.BOOM:
        return "Mark Boom";
    }
  }
}
