import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_error.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/bloc/shipping_order_bloc.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/widgets/shipping_order_item.dart';

import 'shipping_order_skeleton.dart';

class ShippingOrderList extends StatefulWidget {
  final OrderStatus orderStatus;
  final String emptyTitle;

  const ShippingOrderList(
      {Key? key, required this.orderStatus, required this.emptyTitle})
      : super(key: key);

  @override
  State<ShippingOrderList> createState() => _ShippingOrderListState();
}

class _ShippingOrderListState extends State<ShippingOrderList> {
  final scrollController = ScrollController();
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<ShippingOrderEntity> orderList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.sl<ShippingOrderBloc>()
        ..add(LoadShippingOrder(orderStatus: widget.orderStatus)),
      child: BlocBuilder<ShippingOrderBloc, ShippingOrderState>(
        builder: (context, state) {
          if (state is ShippingOrderLoading) {
            return const ShippingOrderSkeleton();
          } else if (state is ShippingOrderLoaded) {
            if (state.orderList.isNotEmpty) {
              isLoadingMore = state.isLoadMore;
              cannotLoadMore = state.cannotLoadMore;
              orderList = state.orderList;

              scrollListener() {
                if (isLoadingMore || cannotLoadMore) return;
                if (scrollController.position.pixels ==
                    scrollController.position.maxScrollExtent) {
                  context
                      .read<ShippingOrderBloc>()
                      .add(LoadMoreShippingOrder(orderStatus: widget.orderStatus));
                }
              }
              scrollController.addListener(scrollListener);

              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ShippingOrderBloc>()
                      .add(LoadShippingOrder(orderStatus: widget.orderStatus));
                },
                child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 10),
                  itemCount:
                      isLoadingMore ? orderList.length + 1 : orderList.length,
                  itemBuilder: (context, index) {
                    if (index < orderList.length) {
                      return ShippingOrderItem(order: orderList[index]);
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(AppDimen.spacing),
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
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
                      widget.emptyTitle,
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.nonactiveColor),
                    )
                  ],
                ),
              );
            }
          } else {
            return MyError();
          }
        },
      ),
    );
  }
}
