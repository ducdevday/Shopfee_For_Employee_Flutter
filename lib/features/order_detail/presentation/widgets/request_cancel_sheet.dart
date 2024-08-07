part of order_detail;

class RequestCancelSheet extends StatefulWidget {
  final String orderId;

  const RequestCancelSheet({Key? key, required this.orderId}) : super(key: key);

  @override
  State<RequestCancelSheet> createState() => _RequestCancelSheetState();
}

class _RequestCancelSheetState extends State<RequestCancelSheet> {
  String reason = "";

  @override
  void initState() {
    getReason();
    super.initState();
  }

  void getReason() async {
    reason = await context
        .read<OrderDetailBloc>()
        .getCancelRequestReason();
    setState(() {});
  }

  void handleAcceptCancelRequest(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contextDialog) => MyConfirmDialog(
            title: "Confirm",
            content: "Are you sure to Accept Cancel this order",
            callbackOK: () async {
              context.read<OrderDetailBloc>().add(OrderDetailDoAction(
                  orderEventType: OrderEventType.ACCEPT_ORDER_CANCELLATION,
                  orderId: widget.orderId));
              Navigator.pop(contextDialog);
            },
            callbackCancel: () {
              Navigator.pop(contextDialog);
            })).then((value) => Navigator.pop(context));
  }

  void handleRefuseCancelRequest(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contextDialog) => MyConfirmDialog(
            title: "Confirm",
            content: "Are you sure to Refuse Cancel this order",
            callbackOK: () async {
              context.read<OrderDetailBloc>().add(OrderDetailDoAction(
                  orderEventType: OrderEventType.REFUSE_ORDER_CANCELLATION,
                  orderId: widget.orderId));
              Navigator.pop(contextDialog);
            },
            callbackCancel: () {
              Navigator.pop(contextDialog);
            })).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Visibility(
                      visible: false,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.close_rounded)),
                    ),
                    Text(
                      "Request Reason Cancel",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded))
                  ],
                ),
              ),
              SizedBox(
                height: AppDimen.spacing,
              ),
              Text(
                "${reason}",
                style: AppStyle.mediumTextStyleDark,
              ),
              SizedBox(
                height: AppDimen.spacing,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppDimen.spacing),
                  child: ElevatedButton(
                    onPressed: () {
                      handleAcceptCancelRequest(context);
                    },
                    child: const Text("Accept"),
                    style: AppStyle.elevatedButtonStylePrimary,
                  )),
              SizedBox(
                height: AppDimen.spacing,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimen.spacing),
                child: ElevatedButton(
                    onPressed: () {
                      handleRefuseCancelRequest(context);
                    },
                    child: const Text("Refuse"),
                    style: AppStyle.elevatedButtonStyleSecondary),
              ),
              SizedBox(
                height: AppDimen.spacing,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
