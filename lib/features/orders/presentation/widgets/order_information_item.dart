part of orders;

class OrderInformationItem extends StatelessWidget {
  final OrderInformationEntity order;

  const OrderInformationItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationUtil.pushNamed(OrderDetailPage.route, arguments: order.id)
            .then((value) {
          // context
          //     .read<OrdersBloc>()
          //     .add(OrderLoadInformation(orderStatus: order.statusLastEvent));
        });
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: AppDimen.spacing, bottom: 5),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppDimen.screenPadding),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        order.customerName,
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.headingColor),
                      ),
                      Text(
                        "  |  ",
                        style: AppStyle.normalTextStyleDark,
                      ),
                      Text(
                        order.phoneNumber,
                        style: AppStyle.normalTextStyleDark,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 10,
                  indent: AppDimen.screenPadding,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppDimen.spacing),
                  child: Row(children: [
                    Image.network(order.thumbnailUrl, width: 70, height: 70),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.productName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.mediumTextStyleDark.copyWith(
                                    color: AppColor.headingColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${FormatUtil.formatTime(order.timeLastEvent)} - ${FormatUtil.formatDate(order.timeLastEvent)}",
                                  style: AppStyle.normalTextStyleDark,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  OrderStatus.getFormattedName(
                                      order.statusLastEvent),
                                  style: AppStyle.smallTextStyleDark.copyWith(
                                      color: OrderStatus.getBadgeColor(
                                          order.statusLastEvent),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Text(FormatUtil.formatMoney(order.total),
                              style: AppStyle.mediumTextStyleDark.copyWith(
                                color: AppColor.headingColor.withOpacity(0.95),
                              ))
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                if (order.productQuantity > 1) {
                  return Column(
                    children: [
                      const Divider(
                        height: 10,
                        indent: AppDimen.screenPadding,
                      ),
                      Text(
                        "Show more ${order.productQuantity - 1} ${order.productQuantity - 1 > 1 ? "items" : "item"}",
                        style: AppStyle.smallTextStyleDark,
                      )
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShowMoreButton(OrderInformationEntity order) {
    if (order.productName.length > 1) {
      return Column(
        children: [
          const Divider(
            height: 2,
            indent: AppDimen.screenPadding,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Show more products",
            style: AppStyle.smallTextStyleDark,
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
