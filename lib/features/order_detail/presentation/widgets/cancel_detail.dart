part of order_detail;

class CancelDetail extends StatelessWidget {
  const CancelDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess) {
          final lastEventLog = state.lastEventLog;
          if (lastEventLog.orderStatus == OrderStatus.CANCELED) {
            return Column(
              children: [
                Container(
                  height: 4,
                  color: const Color(0xffEFEBE9),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimen.spacing),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Canceled Detail",
                            style: AppStyle.mediumTitleStyleDark
                                .copyWith(color: AppColor.headingColor)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Request By",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            lastEventLog.makerByEmployee!
                                ? "Employee"
                                : "User",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Request at",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${FormatUtil.formatTime(lastEventLog.time)} ${FormatUtil.formatDate2(lastEventLog.time)}",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reason",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "${lastEventLog.description}",
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
