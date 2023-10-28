import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';

class ShippingOrderTabBar extends StatelessWidget {
  const ShippingOrderTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: AppColor.disableColor,
      indicatorColor: AppColor.primaryColor,
      labelColor: AppColor.primaryColor,
      tabs: OrderStatus.values.map((e) => Tab(
        // height: 80,
        child: Column(
          children: [
            Text(
              e.name,
              style: AppStyle.mediumTextStyleDark,
            )
          ],
        ),
      )).toList()
    );
  }
}
