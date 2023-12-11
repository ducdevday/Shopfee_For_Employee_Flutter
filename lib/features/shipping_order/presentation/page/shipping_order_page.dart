import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/widgets/shipping_order_list.dart';

class ShippingOrderPage extends StatelessWidget {
  const ShippingOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffEFEBE9),
        appBar: AppBar(
          title: const Text("Shipping Order Today"),
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: AppColor.disableColor,
              indicatorColor: AppColor.primaryColor,
              labelColor: AppColor.primaryColor,
              tabs: OrderStatus.orderStatusProcessing()
                  .map((e) => Tab(
                        child: Text(
                          e,
                          style: AppStyle.mediumTextStyleDark,
                        ),
                      ))
                  .toList()
                  .sublist(0, 3)),
        ),
        body: const TabBarView(
          children: [
            ShippingOrderList(orderStatus: OrderStatus.CREATED, emptyTitle: "No Created Orders Yet"),
            ShippingOrderList(orderStatus: OrderStatus.ACCEPTED, emptyTitle: "No Accepted Orders Yet"),
            ShippingOrderList(orderStatus: OrderStatus.DELIVERING, emptyTitle: "No Delivering Orders Yet")
          ],
        ),
      ),
    );
  }
}

