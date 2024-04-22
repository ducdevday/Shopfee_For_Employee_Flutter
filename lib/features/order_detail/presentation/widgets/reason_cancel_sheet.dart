part of order_detail;

class ReasonCancelSheet extends StatelessWidget {
  final String orderId;

  const ReasonCancelSheet({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess) {
          return Wrap(
            // child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    "Choose Reason For Cancel",
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
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          context.read<OrderDetailBloc>().add(
                              OrderDetailChooseReasonCancel(
                                  reasonCancel:
                                      ReasonCancelType.values[index]));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(ReasonCancelType.getString(
                                      ReasonCancelType.values[index]))),
                              const SizedBox(
                                width: 4,
                              ),
                              Radio<ReasonCancelType>(
                                  activeColor: AppColor.primaryColor,
                                  value: ReasonCancelType.values[index],
                                  groupValue: state.reasonCancel,
                                  onChanged: (ReasonCancelType? value) {
                                    context.read<OrderDetailBloc>().add(
                                        OrderDetailChooseReasonCancel(
                                            reasonCancel: ReasonCancelType
                                                .values[index]));
                                  })
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        height: 10,
                        indent: 10,
                        endIndent: 10,
                      ),
                  itemCount: ReasonCancelType.values.length),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(AppDimen.spacing),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext contextDialog) =>
                              MyConfirmDialog(
                                  title: "Confirm",
                                  content: "Are you sure to CANCEL this order",
                                  callbackOK: () async {
                                    context.read<OrderDetailBloc>().add(
                                        OrderDetailDoAction(
                                            orderEventType:
                                                OrderEventType.ORDER_REFUSE,
                                            orderId: orderId,
                                            description:
                                                ReasonCancelType.getString(
                                                    state.reasonCancel)));
                                    Navigator.pop(contextDialog);
                                  },
                                  callbackCancel: () {
                                    Navigator.pop(contextDialog);
                                  })).then((value) => Navigator.pop(context));
                    },
                    child: const Text("Confirm Cancel"),
                    style: AppStyle.elevatedButtonStylePrimary.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.error)),
                  ))
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
