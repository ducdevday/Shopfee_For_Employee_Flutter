part of order_detail;

class OrderDetailBottom extends StatelessWidget {
  final String orderId;

  const OrderDetailBottom({
    super.key,
    required this.orderId,
  });

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
          final orderDetail = state.orderDetail;
          final orderStatus = state.lastEventLog.orderStatus;
          final orderType = state.orderDetail.orderType!;
          if (orderStatus != null &&
              (!orderStatus.isInFinished() ||
                  orderDetail.refundRequestStatus ==
                      RefundRequestStatus.REFUNDED)) {
            return BottomAppBar(
                child: Row(
              children: [
                Expanded(
                  child:
                      buildOrderActionWidget(orderStatus, orderType, context),
                ),
                buildOrderRefundRequestWidget(
                    orderDetail, orderStatus, context),
                buildOrderRefuseWidget(orderStatus, context),
                buildOrderCancelRequestWidget(orderStatus, context),
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

  Widget buildOrderRefundRequestWidget(OrderDetailEntity orderDetail,
      OrderStatus orderStatus, BuildContext context) {
    if (orderStatus == OrderStatus.SUCCEED &&
        orderDetail.refundRequestStatus == RefundRequestStatus.REFUNDED) {
      return GestureDetector(
        onTap: () {
          NavigationUtil.pushNamed(RefundPage.route, arguments: orderId);
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
                    "Check Request Refund",
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
  }

  Widget buildOrderCancelRequestWidget(
      OrderStatus orderStatus, BuildContext context) {
    if (orderStatus == OrderStatus.CANCELLATION_REQUEST) {
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
  }

  Widget buildOrderRefuseWidget(OrderStatus orderStatus, BuildContext context) {
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
    }
    return SizedBox();
  }

  Row buildOrderActionWidget(
      OrderStatus orderStatus, OrderType orderType, BuildContext context) {
    final orderAction = orderType == OrderType.SHIPPING
        ? orderStatus.orderShippingAction()
        : orderStatus.orderOnsiteAction();
    final orderAlternativeAction = orderType == OrderType.SHIPPING
        ? orderStatus.orderShippingAction(isAlternative: true)
        : orderStatus.orderOnsiteAction(isAlternative: true);
    return Row(
      children: [
        if (orderAction != null)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext contextDialog) => MyConfirmDialog(
                        title: "Confirm",
                        content:
                            "Are you sure to ${orderAction.getFormattedString()} this order",
                        callbackOK: () async {
                          context.read<OrderDetailBloc>().add(
                              OrderDetailDoAction(
                                  orderEventType: orderAction,
                                  orderId: orderId));
                          Navigator.pop(contextDialog);
                        },
                        callbackCancel: () {
                          Navigator.pop(contextDialog);
                        }));
              },
              style: AppStyle.elevatedButtonStylePrimary,
              child: Text("${orderAction.getFormattedString()}"),
            ),
          ),
        if (orderAlternativeAction != null)
          SizedBox(
            width: AppDimen.spacing,
          ),
        if (orderAlternativeAction != null)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext contextDialog) => MyConfirmDialog(
                        title: "Confirm",
                        content:
                            "Are you sure to ${orderAlternativeAction.getFormattedString()} this order",
                        callbackOK: () async {
                          context.read<OrderDetailBloc>().add(
                              OrderDetailDoAction(
                                  orderEventType: orderAlternativeAction,
                                  orderId: orderId));
                          Navigator.pop(contextDialog);
                        },
                        callbackCancel: () {
                          Navigator.pop(contextDialog);
                        }));
              },
              style: AppStyle.elevatedButtonStyleSecondary,
              child: Text("${orderAlternativeAction.getFormattedString()}"),
            ),
          ),
      ],
    );
  }
}
