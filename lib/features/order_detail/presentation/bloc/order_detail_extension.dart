part of order_detail;

extension OrderDetailExtension on OrderDetailLoadSuccess {
  EventLogEntity? getCancelDetail() {
    final statusList = eventLogs.map((e) => e.orderStatus).toList();
    final indexOfCancelRequest =
    statusList.indexOf(OrderStatus.CANCELLATION_REQUEST);
    final indexOfCancel = statusList.indexOf(OrderStatus.CANCELED);
    final indexOfSuccess = statusList.indexOf(OrderStatus.SUCCEED);
    final indexOfNotReceive = statusList.indexOf(OrderStatus.NOT_RECEIVED);

    if (indexOfSuccess != -1) {
      return null;
    } else if (indexOfNotReceive != -1) {
      return null;
    } else if (indexOfCancelRequest != -1 && indexOfCancel != -1) {
      return eventLogs.elementAt(indexOfCancelRequest);
    } else if (indexOfCancel != -1) {
      return eventLogs.elementAt(indexOfCancel);
    }
    return null;
  }
}
