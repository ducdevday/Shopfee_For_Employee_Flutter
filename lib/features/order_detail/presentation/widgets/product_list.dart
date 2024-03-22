part of order_detail;

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late int defaultLength = 3;
  late int maxLength = 3;
  late int boughtListLength;
  late String defaultText = "Show more";
  late Icon defaultIcon = const Icon(Icons.keyboard_arrow_down_rounded);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimen.spacing),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Item list",
                  style: AppStyle.mediumTextStyleDark.copyWith(fontWeight: FontWeight.w600))
              ),
              BlocBuilder<OrderDetailBloc, OrderDetailState>(
                builder: (context, state) {
                  if (state is OrderDetailLoadSuccess) {
                    boughtListLength = state.orderDetail.itemList!.length;
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: boughtListLength < defaultLength
                          ? boughtListLength
                          : maxLength,
                      itemBuilder: (context, index) {
                        return buildProductItem(
                            state.orderDetail.itemList![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 10,
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          if (defaultLength < boughtListLength) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 1,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    onPressed: () {
                      if (maxLength == 3) {
                        setState(() {
                          maxLength = boughtListLength;
                          defaultText = "Show less";
                          defaultIcon =
                              const Icon(Icons.keyboard_arrow_up_rounded);
                        });
                      } else {
                        setState(() {
                          maxLength = 3;
                          defaultText = "Show more";
                          defaultIcon =
                              const Icon(Icons.keyboard_arrow_down_rounded);
                        });
                      }
                    },
                    label: Text(defaultText),
                    icon: defaultIcon,
                  ),
                ),
              ],
            );
          } else {
            return const Padding(padding: EdgeInsets.only(bottom: 8));
          }
        })
      ],
    );
  }

  Widget buildProductItem(OrderProductEntity product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${product.name}",
            style: AppStyle.mediumTitleStyleDark
                .copyWith(color: AppColor.headingColor)
                .copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 6,
        ),
        ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final detail = product.itemDetailList![index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 18,
                      height:18,
                      decoration:  BoxDecoration(
                        color: AppColor.dividerColor,
                        borderRadius: BorderRadius.all(Radius.circular(4))
                      ),
                      child: Center(child: Text("${detail.quantity}", style: AppStyle.mediumTextStyleDark,))),
                  SizedBox(width: AppDimen.spacing,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.size!,
                          style: AppStyle.normalTextStyleDark,
                        ),
                        if (detail.toppings != null &&
                            detail.toppings!.isNotEmpty)
                          Text(detail.toppingOrderString,
                              style: AppStyle.normalTextStyleDark),
                        if (detail.note != null && detail.note!.isNotEmpty)
                          Row(children: [
                            Icon(
                              Icons.sticky_note_2_outlined,
                              color: AppColor.primaryColor,
                              size: 18,
                            ),
                            Expanded(
                              child: Text(
                                detail.note!,
                                style: AppStyle.normalTextStyleDark,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ])
                      ],
                    ),
                  ),
                  Text(FormatUtil.formatMoney(detail.total)),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 4);
            },
            itemCount: product.itemDetailList!.length)
      ],
    );
  }
}
