part of order_detail;

class OrderDetailBottom extends StatelessWidget {
  final String orderId;

  const OrderDetailBottom({
    super.key,
    required this.orderId,
  });

  String eventLogDescription(OrderStatus orderStatus, String orderId) {
    switch (orderStatus) {
      case OrderStatus.CREATED:
        return "Your order $orderId was created. If after 10 minutes, order hasn't accepted, please call the hotline: 0334901237.";
      case OrderStatus.ACCEPTED:
        return "Your order $orderId was accepted. Please wait for us to process your order.";
      case OrderStatus.CANCELLATION_REQUEST:
        return "Your request cancel order $orderId was send. Please wait for us to consider your reason.";
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
        return "Your request cancel order $orderId was refused.";
      case OrderStatus.CANCELLATION_REQUEST_ACCEPTED:
        return "Your request cancel order $orderId was accepted.";
      case OrderStatus.DELIVERING:
        return "Your order $orderId is delivering. Please pay attention to your phone in case the shipper call you.";
      case OrderStatus.SUCCEED:
        return "You have get your order. Thank you for choosing Shopfee.";
      case OrderStatus.CANCELED:
        return "Your order was canceled.";
      default:
        return "";
    }
  }

  Future<void> buildShowReasonCancelSheet(
      BuildContext context, String orderId) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<OrderDetailBloc>(),
          child: ReasonCancelSheet(
            orderId: orderId,
          ),
        );
      },
    );
  }

  Future<void> buildShowRequestCancelSheet(
      BuildContext context, String orderId) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<OrderDetailBloc>(),
          child: RequestCancelSheet(
            orderId: orderId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess) {
          final orderStatus = state.lastEventLog.orderStatus;
          if (orderStatus != null && !orderStatus.isInFinished()) {
            final orderActionStatus = orderStatus.orderActionStatus();
            final orderActionString = orderStatus.orderActionString();
            return BottomAppBar(
                child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: !orderStatus.isInCancelRequest()
                        ? () {
                            showDialog(
                                context: context,
                                builder: (BuildContext contextDialog) =>
                                    MyConfirmDialog(
                                        title: "Confirm",
                                        content:
                                            "Are you sure to ${orderActionString} this order",
                                        callbackOK: () async {
                                          context.read<OrderDetailBloc>().add(
                                              OrderDetailAddEventLog(
                                                  orderId: orderId,
                                                  eventLog: EventLogEntity(
                                                      orderStatus:
                                                          orderActionStatus,
                                                      description:
                                                          eventLogDescription(
                                                              orderActionStatus!,
                                                              orderId))));
                                          Navigator.pop(contextDialog);
                                        },
                                        callbackCancel: () {
                                          Navigator.pop(contextDialog);
                                        }));
                          }
                        : null,
                    style: AppStyle.elevatedButtonStylePrimary,
                    child: Text("${orderActionString}"),
                  ),
                ),
                Builder(builder: (context) {
                  if (orderStatus == OrderStatus.CREATED) {
                    return GestureDetector(
                      onTap: () {
                        buildShowReasonCancelSheet(context, orderId);
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cancel,
                                  color: AppColor.paragraphColor,
                                ),
                                Text(
                                  "Cancel",
                                  style: AppStyle.normalTextStyleDark,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  } else if (orderStatus == OrderStatus.CANCELLATION_REQUEST) {
                    return GestureDetector(
                      onTap: () {
                        buildShowRequestCancelSheet(context, orderId);
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info,
                                  color: AppColor.paragraphColor,
                                ),
                                Text(
                                  "Check Request Cancel",
                                  style: AppStyle.normalTextStyleDark,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox();
                }),
              ],
            ));
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}
