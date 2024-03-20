import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';

enum OrderStatus {
  CREATED,
  ACCEPTED,
  CANCELLATION_REQUEST,
  CANCELLATION_REQUEST_REFUSED,
  CANCELLATION_REQUEST_ACCEPTED,
  DELIVERING,
  SUCCEED,
  CANCELED;

  String toJson() => name;

  static OrderStatus fromJson(String json) => values.byName(json);

  static List<String> orderStatusShippingProcessing() => [
        "New Order",
        "Preparing Order",
        "Request Cancel Order",
        "Delivering Order"
      ];

  static List<String> orderStatusFinished() => ["Succeed", "Canceled"];

  static String orderStatusAction(OrderStatus? orderStatus) {
    if (orderStatus == OrderStatus.CREATED) {
      return "Accept";
    } else if (orderStatus == OrderStatus.ACCEPTED) {
      return "Delivery";
    } else if (orderStatus == OrderStatus.DELIVERING) {
      return "Finish";
    }
    return "";
  }

  static String getFormattedName(OrderStatus? orderStatus) {
    switch (orderStatus) {
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
      case OrderStatus.DELIVERING:
        return "DELIVERING";
      case OrderStatus.SUCCEED:
        return "SUCCEED";
      case OrderStatus.CANCELED:
        return "CANCELED";
      default:
        return "";
    }
  }

  static Color getBadgeColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.SUCCEED:
        return AppColor.success;
      case OrderStatus.CANCELED:
        return AppColor.error;
      default:
        return AppColor.primaryColor;
    }
  }

  static OrderStatus? statusPreviousEvent(OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.CANCELED) {
      return OrderStatus.CREATED;
    } else if (orderStatus == OrderStatus.ACCEPTED) {
      return OrderStatus.CREATED;
    }
    if (orderStatus == OrderStatus.DELIVERING) {
      return OrderStatus.ACCEPTED;
    }
    if (orderStatus == OrderStatus.SUCCEED) {
      return OrderStatus.DELIVERING;
    }
    return null;
  }

  static String getEmptyOrderStatusList(OrderStatus status) {
    switch (status) {
      case OrderStatus.CREATED:
        return "No Created Orders Yet";
      case OrderStatus.ACCEPTED:
        return "No Created ACCEPTED Yet";
      case OrderStatus.CANCELLATION_REQUEST:
        return "No Request Cancel Orders Yet";
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
        return "No Refused Request Cancel Yet";
      case OrderStatus.CANCELLATION_REQUEST_ACCEPTED:
        return "No Accepted Orders Yet";
      case OrderStatus.DELIVERING:
        return "No Delivering Orders Yet";
      case OrderStatus.SUCCEED:
        return "No Succeed Orders Yet";
      case OrderStatus.CANCELED:
        return "No Canceled Orders Yet";
    }
  }
}
