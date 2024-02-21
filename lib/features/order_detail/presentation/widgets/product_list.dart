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
  late int productListLength;
  late String defaultText = "Show more";
  late Icon defaultIcon = Icon(Icons.keyboard_arrow_down_rounded);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Item List",
                  style: AppStyle.mediumTitleStyleDark.copyWith(
                      color: AppColor.headingColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              BlocBuilder<OrderDetailBloc, OrderDetailState>(
                builder: (context, state) {
                  if (state is OrderDetailLoadSuccess) {
                    productListLength =
                        state.orderDetail.products!.length;
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productListLength < defaultLength
                          ? productListLength
                          : maxLength,
                      itemBuilder: (context, index) {
                        return buildProductItem(state, index);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 10,
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          if (defaultLength < productListLength) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    onPressed: () {
                      if (maxLength == 3) {
                        setState(() {
                          maxLength = productListLength;
                          defaultText = "Show less";
                          defaultIcon = Icon(Icons.keyboard_arrow_up_rounded);
                        });
                      } else {
                        setState(() {
                          maxLength = 3;
                          defaultText = "Show more";
                          defaultIcon = Icon(Icons.keyboard_arrow_down_rounded);
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
            return Padding(padding: EdgeInsets.only(bottom: 8));
          }
        })
      ],
    );
  }

  Widget buildProductItem(OrderDetailLoadSuccess state, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${state.orderDetail.products![index].quantity}x ${state.orderDetail.products![index].name!}",
                  style: AppStyle.mediumTitleStyleDark
                      .copyWith(color: AppColor.headingColor)
                      .copyWith(fontWeight: FontWeight.w500)),
              SizedBox(
                height: 6,
              ),
              Text(
                state.orderDetail.products![index].size!,
                style: AppStyle.normalTextStyleDark,
              ),
              state.orderDetail.products![index].toppings!.isNotEmpty
                  ? Text(FormatUtil.formattedArrayString(state.orderDetail.products![index].toppings!.map((topping) => topping.name).toList()),
                      style: AppStyle.normalTextStyleDark)
                  : SizedBox(),
              state.orderDetail.products![index].note!.isNotEmpty
                  ? Row(
                      children: [
                        Icon(
                          Icons.sticky_note_2_outlined,
                          color: AppColor.primaryColor,
                          size: 18,
                        ),
                        Expanded(
                          child: Text(
                            state.orderDetail.products![index].note!,
                            style: AppStyle.normalTextStyleDark,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  : SizedBox()
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(FormatUtil.formattedMoney(state.orderDetail.products![index].price!),
                  style: AppStyle.mediumTitleStyleDark
                      .copyWith(color: AppColor.headingColor)),
            ],
          ),
        )
      ],
    );
  }
}
