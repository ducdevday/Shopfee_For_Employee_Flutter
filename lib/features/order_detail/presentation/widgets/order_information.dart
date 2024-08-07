part of order_detail;

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimen.spacing),
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
                      "ID Order",
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
                      FormatUtil.formatDate(state.orderDetail.createdAt!),
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
                      FormatUtil.formatTime(state.orderDetail.createdAt!),
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
                if (state.orderDetail.employee != null)
                  Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cashier",
                            style: AppStyle.mediumTitleStyleDark,
                          ),
                          Text(
                            "${state.orderDetail.employee!.id}-${state.orderDetail.employee!.name}",
                            style: AppStyle.normalTextStyleDark,
                          )
                        ],
                      ),
                    ],
                  )
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
