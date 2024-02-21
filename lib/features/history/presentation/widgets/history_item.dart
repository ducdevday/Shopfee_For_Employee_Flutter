part of history;

class HistoryItem extends StatelessWidget {
  final HistoryEntity history;

  const HistoryItem({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailPage.route,
            arguments: history.id);
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
                        history.customerName,
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.headingColor),
                      ),
                      Text(
                        "  |  ",
                        style: AppStyle.normalTextStyleDark,
                      ),
                      Text(
                        history.phoneNumber,
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
                    Image.network(history.thumbnailUrl, width: 70, height: 70),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  history.productName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.mediumTextStyleDark.copyWith(
                                    color: AppColor.headingColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                history.statusLastEvent.name,
                                style: AppStyle.mediumTextStyleDark.copyWith(
                                    color: history.statusLastEvent ==
                                            OrderStatus.SUCCEED
                                        ? AppColor.success
                                        : AppColor.error),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${FormatUtil.formattedTime(history.timeLastEvent)} - ${FormatUtil.formattedDate(history.timeLastEvent)}",
                                    style: AppStyle.normalTextStyleDark,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Total: ${FormatUtil.formattedMoney(history.total)}",
                                    style:
                                        AppStyle.mediumTextStyleDark.copyWith(
                                      color: AppColor.headingColor
                                          .withOpacity(0.95),
                                    ),
                                  ),
                                ],
                              ),
                              Builder(builder: (context) {
                                if (history.orderType == OrderType.SHIPPING) {
                                  return SvgPicture.asset(
                                    "assets/icons/ic_delivery.svg",
                                    width: 50,
                                    height: 50,
                                  );
                                } else {
                                  return SvgPicture.asset(
                                    "assets/icons/ic_take_away.svg",
                                    width: 50,
                                    height: 50,
                                  );
                                }
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                if (history.productQuantity > 1) {
                  return Column(
                    children: [
                      const Divider(
                        height: 10,
                        indent: AppDimen.screenPadding,
                      ),
                      Text(
                        "Show more ${history.productQuantity - 1} ${history.productQuantity - 1 > 1 ? "items" : "item"}",
                        style: AppStyle.smallTextStyleDark,
                      )
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const Divider(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, OrderDetailPage.route,
                          arguments: history.id);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30)),
                    child: Text("See Detail"),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
