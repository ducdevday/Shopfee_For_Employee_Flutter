import 'dart:ui';

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
        "Not Received Order"
      ];

  static List<String> orderStatusFinished() => ["Succeed", "Canceled"];

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
        return true;
      default:
        return false;
    }
  }

  String orderActionString() {
    switch (this) {
      case OrderStatus.CREATED:
        return "Accept";
      case OrderStatus.ACCEPTED:
        return "Prepare";
      case OrderStatus.PREPARED:
      case OrderStatus.CANCELLATION_REQUEST:
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
      case OrderStatus.CANCELLATION_REQUEST_ACCEPTED:
        return "Delivery";
      case OrderStatus.DELIVERING:
        return "Finish";
      default:
        return "";
    }
  }

  OrderStatus? orderActionStatus() {
    switch (this) {
      case OrderStatus.CREATED:
        return OrderStatus.ACCEPTED;
      case OrderStatus.ACCEPTED:
        return OrderStatus.PREPARED;
      case OrderStatus.PREPARED:
        return OrderStatus.DELIVERING;
      case OrderStatus.DELIVERING:
        return OrderStatus.SUCCEED;
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
      case OrderStatus.PREPARED:
        return "PREPARED";
      case OrderStatus.DELIVERING:
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
      case OrderStatus.PREPARED:
        return "No Prepared Orders Yet";
      case OrderStatus.DELIVERING:
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
