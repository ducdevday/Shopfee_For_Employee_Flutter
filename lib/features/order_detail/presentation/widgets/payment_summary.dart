part of order_detail;

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess) {
          return Padding(
            padding: const EdgeInsets.all(AppDimen.spacing),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Payment Summary",
                      style: AppStyle.mediumTitleStyleDark
                          .copyWith(color: AppColor.headingColor)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Item Price",
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      FormatUtil.formatMoney(state.orderDetail.totalItemPrice!),
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping fee",
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      FormatUtil.formatMoney(
                          state.orderDetail.shippingFee ?? 0),
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                buildAppliedShippingCouponWidget(state),
                buildAppliedOrderCouponWidget(state),
                buildAppliedCoinWidget(state),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      FormatUtil.formatMoney(state.orderDetail.totalPayment!),
                      style: AppStyle.mediumTitleStyleDark,
                    )
                  ],
                ),
                const Divider(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style: AppStyle.mediumTitleStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    buildPaymentMethod(state.orderDetail.transaction?.type),
                  ],
                ),
                const Divider(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Status",
                        style: AppStyle.mediumTitleStyleDark.copyWith(
                            color: AppColor.headingColor,
                            fontWeight: FontWeight.w500),
                      ),
                      buildPaymentStatus(state.orderDetail.transaction?.status),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildAppliedShippingCouponWidget(OrderDetailLoadSuccess state) {
    if (state.orderDetail.discountInformation?.shippingDiscount != null) {
      return Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Shipping Fee Discount",
                  style: AppStyle.normalTextStyleDark
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: Text(
                  "- ${FormatUtil.formatMoney(state.orderDetail.discountInformation?.shippingDiscount)}",
                  style: AppStyle.normalTextStyleDark
                      .copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ],
      );
    }
    return SizedBox();
  }

  Widget buildAppliedOrderCouponWidget(OrderDetailLoadSuccess state) {
    if (state.orderDetail.discountInformation?.shippingDiscount != null) {
      return Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Order Discount",
                  style: AppStyle.normalTextStyleDark
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: Text(
                  "- ${FormatUtil.formatMoney(state.orderDetail.discountInformation?.orderDiscount)}",
                  style: AppStyle.normalTextStyleDark
                      .copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ],
      );
    }
    return SizedBox();
  }

  Widget buildAppliedCoinWidget(OrderDetailLoadSuccess state) {
    if (state.orderDetail.coin != null && state.orderDetail.coin != 0) {
      return Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Applied Coin",
                  style: AppStyle.normalTextStyleDark
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: Text(
                  "- ${FormatUtil.formatMoney(state.orderDetail.coin)}",
                  style: AppStyle.normalTextStyleDark
                      .copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ],
      );
    }
    return SizedBox();
  }

  Widget buildPaymentStatus(PaymentStatus? paymentStatus) {
    if (paymentStatus == null) return SizedBox();
    return MyLabel(
        label: PaymentStatus.getFormattedName(paymentStatus),
        color: PaymentStatus.getColor(paymentStatus));
  }

  Widget buildPaymentMethod(PaymentType? paymentType) {
    if (paymentType == null) return SizedBox();
    return Row(
      children: [
        Image.asset(
          PaymentType.getIconPath(paymentType),
          width: 24,
          height: 24,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(PaymentType.getFormattedName(paymentType),
            style: AppStyle.normalTextStyleDark),
      ],
    );
  }
}
