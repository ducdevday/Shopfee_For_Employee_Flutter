import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';

enum PaymentStatus {
  PAID,
  UNPAID,
  REFUNDED,
  FAILED
  ;

  String toJson() => name;

  static PaymentStatus fromJson(String json) => values.byName(json);

  static String getFormattedName(PaymentStatus paymentStatus) {
    switch (paymentStatus) {
      case PaymentStatus.PAID:
        return "Paid";
      case PaymentStatus.UNPAID:
        return "Unpaid";
      case PaymentStatus.REFUNDED:
        return "Refunded";
      case PaymentStatus.FAILED:
        return "Failed";
    }
  }

  static Color getColor(PaymentStatus paymentStatus) {
    switch (paymentStatus) {
      case PaymentStatus.PAID:
        return AppColor.success;
      case PaymentStatus.UNPAID:
        return AppColor.warning;
      case PaymentStatus.REFUNDED:
        return AppColor.info;
      case PaymentStatus.FAILED:
        return AppColor.error;
    }
  }
}