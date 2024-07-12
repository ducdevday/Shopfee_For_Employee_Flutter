import 'dart:ui';

import 'package:shopfeeforemployee/core/common/enum/order_event_type.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';

extension OrderStatusExtension on OrderStatus {
  String toJson() => this.toString();

  static OrderStatus fromJson(String json) =>
      OrderStatus.values.firstWhere((e) => e.toString() == json);

  static List<String> orderStatusShippingProcessing() => [
        "New Order",
        "Accepted Order",
        "Prepared Order",
        "Request Cancel Order",
        "Delivering Order",
      ];

  static List<String> orderStatusOnSiteProcessing() => [
        "New Order",
        "Accepted Order",
        "Prepared Order",
        "Request Cancel Order",
      ];

  static List<String> orderStatusFinished() =>
      ["Succeed", "Canceled", "Not Received"];

  bool isInCancelRequest() {
    switch (this) {
      case OrderStatus.CANCELLATION_REQUEST:
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
      case OrderStatus.CANCELLATION_REQUEST_ACCEPTED:
        return true;
      default:
        return false;
    }
  }

  bool isInFinished() {
    switch (this) {
      case OrderStatus.SUCCEED:
      case OrderStatus.CANCELED:
      case OrderStatus.NOT_RECEIVED:
        return true;
      default:
        return false;
    }
  }

  OrderEventType? orderShippingAction({bool isAlternative = false}) {
    switch (this) {
      case OrderStatus.CREATED:
        if (isAlternative == false) {
          return OrderEventType.ACCEPT_ORDER;
        } else {
          return null;
        }
      case OrderStatus.ACCEPTED:
        if (isAlternative == false) {
          return OrderEventType.PREPARED;
        } else {
          return null;
        }
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
        if (isAlternative == false) {
          return OrderEventType.PREPARED;
        } else {
          return null;
        }
      case OrderStatus.PENDING_PICK_UP:
        if (isAlternative == false) {
          return OrderEventType.START_SHIPPING;
        } else {
          return null;
        }
      case OrderStatus.IN_DELIVERY:
        if (isAlternative == false) {
          return OrderEventType.FULFILL;
        } else {
          return OrderEventType.BOOM;
        }
      default:
        return null;
    }
  }

  OrderEventType? orderOnsiteAction({bool isAlternative = false}) {
    switch (this) {
      case OrderStatus.CREATED:
        if (isAlternative == false) {
          return OrderEventType.ACCEPT_ORDER;
        } else {
          return null;
        }
      case OrderStatus.ACCEPTED:
        if (isAlternative == false) {
          return OrderEventType.PREPARED;
        } else {
          return null;
        }
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
        if (isAlternative == false) {
          return OrderEventType.PREPARED;
        } else {
          return null;
        }
      case OrderStatus.PENDING_PICK_UP:
        if (isAlternative == false) {
          return OrderEventType.FULFILL;
        } else {
          return OrderEventType.BOOM;
        }
      default:
        return null;
    }
  }

  String getFormattedName() {
    switch (this) {
      case OrderStatus.CREATED:
        return "CREATED";
      case OrderStatus.ACCEPTED:
        return "ACCEPTED";
      case OrderStatus.CANCELLATION_REQUEST:
        return "REQUEST CANCEL IN PROCESS";
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
        return "REQUEST CANCEL REFUSED";
      case OrderStatus.CANCELLATION_REQUEST_ACCEPTED:
        return "REQUEST CANCEL ACCEPTED";
      case OrderStatus.PENDING_PICK_UP:
        return "PREPARED";
      case OrderStatus.IN_DELIVERY:
        return "DELIVERING";
      case OrderStatus.NOT_RECEIVED:
        return "NOT RECEIVED";
      case OrderStatus.SUCCEED:
        return "SUCCEED";
      case OrderStatus.CANCELED:
        return "CANCELED";
    }
  }

  Color getBadgeColor() {
    switch (this) {
      case OrderStatus.SUCCEED:
        return AppColor.success;
      case OrderStatus.CANCELED:
        return AppColor.error;
      default:
        return AppColor.primaryColor;
    }
  }

  String getEmptyOrderStatusList() {
    switch (this) {
      case OrderStatus.CREATED:
        return "No Created Orders Yet";
      case OrderStatus.ACCEPTED:
        return "No Accepted Orders Yet";
      case OrderStatus.CANCELLATION_REQUEST:
        return "No Request Cancel Orders Yet";
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
        return "No Refused Request Cancel Yet";
      case OrderStatus.CANCELLATION_REQUEST_ACCEPTED:
        return "No Refused Request Accept Orders Yet";
      case OrderStatus.PENDING_PICK_UP:
        return "No Prepared Orders Yet";
      case OrderStatus.IN_DELIVERY:
        return "No Delivering Orders Yet";
      case OrderStatus.NOT_RECEIVED:
        return "NOT RECEIVED";
      case OrderStatus.SUCCEED:
        return "No Succeed Orders Yet";
      case OrderStatus.CANCELED:
        return "No Canceled Orders Yet";
      default:
        return "";
    }
  }
}
