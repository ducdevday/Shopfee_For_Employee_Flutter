part of order_detail;


class OrderInformation extends StatelessWidget {
  const OrderInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailLoadSuccess) {
            return Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID Transaction",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      state.orderDetail.id!,
                      style: AppStyle.normalTextStyleDark,
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
                      "Date",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      FormatUtil.formatDate(
                          state.orderDetail.createdAt!),
                      style: AppStyle.normalTextStyleDark,
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
                      "Time",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      FormatUtil.formatTime(
                          state.orderDetail.createdAt!),
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
