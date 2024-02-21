enum ReasonCancelType {
  SOLD_OUT,
  SHIPPER_NOT_AVAILABLE,
  CLOSED_TODAY,
  ORDER_REASON;

  static String getString(ReasonCancelType? type) {
    switch (type) {
      case ReasonCancelType.SOLD_OUT:
        return "This product was sold out";
      case ReasonCancelType.SHIPPER_NOT_AVAILABLE:
        return "Shipper of Shopfee is not available at present";
      case ReasonCancelType.CLOSED_TODAY:
        return "Shopfee is closed today";
      case ReasonCancelType.ORDER_REASON:
        return "Other reason";
      case null:
        return "";
      default:
        return "";
    }
  }

  final List<String> reasons = const [
    "This product was sold out",
    "Shipper of Shopfee is not available at present",
    "Shopfee is closed today",
    "Other reason"
  ];
}
