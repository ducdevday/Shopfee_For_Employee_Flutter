import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/widgets/shipping_order_item.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/widgets/shipping_order_tabbar.dart';

class ShippingOrderPage extends StatelessWidget {
  const ShippingOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: OrderStatus.values.length,
      child: Scaffold(
        backgroundColor: Color(0xffEFEBE9),
        appBar: AppBar(
          title: Text("Shipping Order"),
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: AppColor.disableColor,
              indicatorColor: AppColor.primaryColor,
              labelColor: AppColor.primaryColor,
              tabs: OrderStatus.values.map((e) => Tab(
                child: Text(
                  e.name,
                  style: AppStyle.mediumTextStyleDark,
                ),
              )).toList()
          ),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              padding: EdgeInsets.only(top: 10),
              itemCount: 3,
              itemBuilder: (context, index) => ShippingOrderItem(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
            Center(
              child: Icon(Icons.account_circle),
            ),
            Center(
              child: Icon(Icons.alarm),
            )
          ],
        ),
      ),
    );
  }
}
