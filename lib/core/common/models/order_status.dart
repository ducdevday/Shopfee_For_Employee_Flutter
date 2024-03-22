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
  CANCELED
}
