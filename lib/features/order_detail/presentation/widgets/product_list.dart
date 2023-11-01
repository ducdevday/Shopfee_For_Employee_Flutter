import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/utils/converter_util.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/bloc/order_detail_bloc.dart';

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
                  "Bought list",
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
                  if (state is OrderDetailLoaded) {
                    productListLength =
                        state.orderDetailEntity.products!.length;
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

  Widget buildProductItem(OrderDetailLoaded state, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${state.orderDetailEntity.products![index].quantity}x ${state.orderDetailEntity.products![index].name!}",
                  style: AppStyle.mediumTitleStyleDark
                      .copyWith(color: AppColor.headingColor)
                      .copyWith(fontWeight: FontWeight.w500)),
              SizedBox(
                height: 6,
              ),
              Text(
                state.orderDetailEntity.products![index].size!,
                style: AppStyle.normalTextStyleDark,
              ),
              state.orderDetailEntity.products![index].toppings!.isNotEmpty
                  ? Text(ConverterUtil.formattedArrayString(state.orderDetailEntity.products![index].toppings!.map((topping) => topping.name).toList()),
                      style: AppStyle.normalTextStyleDark)
                  : SizedBox(),
              state.orderDetailEntity.products![index].note!.isNotEmpty
                  ? Row(
                      children: [
                        Icon(
                          Icons.sticky_note_2_outlined,
                          color: AppColor.primaryColor,
                          size: 18,
                        ),
                        Expanded(
                          child: Text(
                            state.orderDetailEntity.products![index].note!,
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
              Text(ConverterUtil.formattedMoney(state.orderDetailEntity.products![index].price!),
                  style: AppStyle.mediumTitleStyleDark
                      .copyWith(color: AppColor.headingColor)),
            ],
          ),
        )
      ],
    );
  }
}
