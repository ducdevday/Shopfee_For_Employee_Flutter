part of order_detail;

class TakeAwayInformation extends StatelessWidget {
  const TakeAwayInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
      if (state is OrderDetailLoadSuccess) {
        if (state.orderDetail.orderType == OrderType.ONSITE) {
          return Padding(
            padding: EdgeInsets.all(AppDimen.spacing),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Take Away In",
                    style: AppStyle.mediumTitleStyleDark.copyWith(
                        color: AppColor.headingColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(AppPath.icStoreMark, width: AppDimen.xSmallSize,height: AppDimen.xSmallSize,),
                        SizedBox(width: AppDimen.smallSpacing,),
                        Expanded(
                          child: Text(
                            "Shopfee ${state.orderDetail.branch?.address}",
                            style: AppStyle.normalTextStyleDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimen.spacing,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(AppPath.icClock, width: AppDimen.xSmallSize,height: AppDimen.xSmallSize,),
                        SizedBox(width: AppDimen.smallSpacing,),
                        Expanded(
                          child: Text(
                            "Chosen Time: ${FormatUtil.formatTime(state.orderDetail.receiverInformation?.receiveTime)} - ${FormatUtil.formatDate2(state.orderDetail.receiverInformation?.receiveTime)}",
                            style: AppStyle.normalTextStyleDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }
      return SizedBox();
    });
  }
}
