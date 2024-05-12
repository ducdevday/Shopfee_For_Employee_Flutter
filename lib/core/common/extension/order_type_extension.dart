import 'package:shopfeeforemployee/core/common/models/order_type.dart';

extension OrderTypeExtension on OrderType {
  String getFormattedName() {
    switch (this) {
      case OrderType.ONSITE:
        return "Take Away";
      case OrderType.SHIPPING:
        return "Home Delivery";
    }
  }
}