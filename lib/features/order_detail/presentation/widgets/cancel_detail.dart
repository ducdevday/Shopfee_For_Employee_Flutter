part of order_detail;

class CancelDetail extends StatelessWidget {
  const CancelDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess && state.getCancelDetail() != null) {
            return Column(
              children: [
                Container(
                  height: 4,
                  color: const Color(0xffEFEBE9),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimen.spacing),
                  child:               Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Canceled Detail",
                            style: AppStyle.mediumTitleStyleDark
                                .copyWith(color: AppColor.headingColor)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Request by",
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${state.getCancelDetail()?.actor?.getFormattedName()}",
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Request at",
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${FormatUtil.formatTime(state.getCancelDetail()?.time)} - ${FormatUtil.formatDate2(state.getCancelDetail()?.time)}",
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Reason",
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${state.getCancelDetail()?.note ?? ""}",
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.end,
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
        return SizedBox();
      },
    );
  }
}
