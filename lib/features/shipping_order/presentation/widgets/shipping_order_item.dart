import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/router/app_router.dart';
import 'package:shopfeeforemployee/core/utils/converter_util.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';

class ShippingOrderItem extends StatelessWidget {
  final ShippingOrderEntity order;

  const ShippingOrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.orderDetailRoute,
            arguments: order.id);
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
                      const Icon(Icons.account_circle_outlined),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Nguyễn Minh Đức",
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.headingColor),
                      ),
                      Text(
                        "  |  ",
                        style: AppStyle.normalTextStyleDark,
                      ),
                      Text(
                        "0334901237",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  order.productName,
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
                                order.statusLastEvent.name,
                                style: AppStyle.mediumTextStyleDark
                                    .copyWith(color: AppColor.primaryColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "${ConverterUtil.formattedTime(order.timeLastEvent)} - ${ConverterUtil.formattedDate(order.timeLastEvent)}",
                            style: AppStyle.normalTextStyleDark,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Total: ${ConverterUtil.formattedMoney(order.total)}",
                            style: AppStyle.mediumTextStyleDark.copyWith(
                              color: AppColor.headingColor.withOpacity(0.95),
                            ),
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
            const Divider(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                        "${OrderStatus.orderStatusAction(order.statusLastEvent)}"),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30)),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildShowMoreButton(ShippingOrderEntity order) {
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
