import 'package:shopfeeforemployee/core/common/enum/order_event_type.dart';

extension OrderEventExtension on OrderEventType {
  String getFormattedString() {
    switch (this) {
      case OrderEventType.ORDER_REFUSE:
        return "Cancel Order";
      case OrderEventType.ORDER_ACCEPT:
        return "Accept Order";
      case OrderEventType.CANCEL_REQUEST_REFUSE:
        return "Refuse Request";
      case OrderEventType.CANCEL_REQUEST_ACCEPT:
        return "Accept Request";
      case OrderEventType.READY_SHIPPING:
        return "Prepared Order";
      case OrderEventType.START_SHIPPING:
        return "Delivery";
      case OrderEventType.ORDER_FULFILL:
        return "Finish";
      case OrderEventType.ORDER_BOOM:
        return "Mark Boom";
    }
  }
}
