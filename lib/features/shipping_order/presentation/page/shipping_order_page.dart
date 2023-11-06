import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_error.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/bloc/shipping_order_bloc.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/widgets/shipping_order_item.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/widgets/shipping_order_skeleton.dart';

class ShippingOrderPage extends StatelessWidget {
  const ShippingOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ServiceLocator.sl<ShippingOrderBloc>()..add(LoadShippingOrder()),
      child: DefaultTabController(
        length: 3,
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
          body: BlocBuilder<ShippingOrderBloc, ShippingOrderState>(
            builder: (context, state) {
              if (state is ShippingOrderLoading) {
                return ShippingOrderSkeleton();
              } else if (state is ShippingOrderLoaded) {
                return TabBarView(
                  children: [
                    buildOrderList(
                        state.createdOrderList, "No Created Orders Yet"),
                    buildOrderList(
                        state.acceptedOrderList, "No Accepted Orders Yet"),
                    buildOrderList(
                        state.deliveringOrderList, "No Delivering Orders Yet"),
                    // buildOrderList(
                    //     state.succeedOrderList, "No Succeed Orders Yet"),
                    // buildOrderList(
                    //     state.canceledOrderList, "No Canceled Orders Yet"),
                  ],
                );
              } else {
                return MyError();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildOrderList(List<ShippingOrderEntity> orderList, String status) {
    if (orderList.isNotEmpty) {
      return ListView.separated(
        padding: EdgeInsets.only(top: 10),
        itemCount: orderList.length,
        itemBuilder: (context, index) =>
            ShippingOrderItem(order: orderList[index]),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/ic_no_order.png",
              width: 60,
              height: 60,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              status,
              style: AppStyle.mediumTextStyleDark
                  .copyWith(color: AppColor.nonactiveColor),
            )
          ],
        ),
      );
    }
  }
}

