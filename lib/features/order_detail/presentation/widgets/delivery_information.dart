part of order_detail;

class DeliveryInformation extends StatelessWidget {
  const DeliveryInformation({Key? key}) : super(key: key);

  Future<void> _makePhoneCall({required String phoneNumber}) async {
    String telQuery = "tel: $phoneNumber";
    if (await canLaunchUrl(Uri.parse(telQuery))) {
      await launchUrl(Uri.parse(telQuery));
    } else {
      throw 'Could not launch $telQuery';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess) {
          if (state.orderDetail.orderType == OrderType.SHIPPING) {
            return Padding(
              padding: const EdgeInsets.all(AppDimen.spacing),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Delivery Address",
                      style: AppStyle.mediumTitleStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${state.orderDetail.receiverInformation?.recipientName}",
                            style: AppStyle.mediumTextStyleDark
                                .copyWith(color: AppColor.headingColor),
                          ),
                          Text(
                            "  |  ",
                            style: AppStyle.normalTextStyleDark,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext contextDialog) =>
                                      MyConfirmDialog(
                                          title: "Call to",
                                          content:
                                              "${state.orderDetail.receiverInformation?.phoneNumber}",
                                          callbackOK: () async {
                                            await _makePhoneCall(
                                                    phoneNumber: state
                                                            .orderDetail
                                                            .receiverInformation
                                                            ?.phoneNumber ??
                                                        "")
                                                .then((value) => Navigator.pop(
                                                    contextDialog));
                                          },
                                          callbackCancel: () {
                                            Navigator.pop(contextDialog);
                                          }));
                            },
                            child: Text(
                              "${state.orderDetail.receiverInformation?.phoneNumber}",
                              style: AppStyle.normalTextStyleDark.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: AppColor.info),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${state.orderDetail.receiverInformation?.detail}",
                        style: AppStyle.normalTextStyleDark,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
