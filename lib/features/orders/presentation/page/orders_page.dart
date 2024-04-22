part of orders;

class OrdersPage extends StatelessWidget {
  static const String route = "/orders";
  final OrderType orderType;

  const OrdersPage({Key? key, required this.orderType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (orderType) {
      case OrderType.SHIPPING:
        return DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: const Color(0xffEFEBE9),
            appBar: AppBar(
              title: const Text("Delivery Order Today"),
              backgroundColor: Colors.white,
              centerTitle: true,
              bottom: TabBar(
                  padding: EdgeInsets.zero,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  unselectedLabelColor: AppColor.disableColor,
                  indicatorColor: AppColor.primaryColor,
                  labelColor: AppColor.primaryColor,
                  tabs: OrderStatusExtension.orderStatusShippingProcessing()
                      .map((e) => Tab(
                            child: Text(
                              e,
                              style: AppStyle.mediumTextStyleDark,
                            ),
                          ))
                      .toList()),
            ),
            body: TabBarView(
              children: [
                OrderInformationList(
                    orderType: orderType, orderStatus: OrderStatus.CREATED),
                OrderInformationList(
                  orderType: orderType,
                  orderStatus: OrderStatus.ACCEPTED,
                ),
                OrderInformationList(
                  orderType: orderType,
                  orderStatus: OrderStatus.PREPARED,
                ),
                OrderInformationList(
                    orderType: orderType,
                    orderStatus: OrderStatus.CANCELLATION_REQUEST),
                OrderInformationList(
                    orderType: orderType, orderStatus: OrderStatus.DELIVERING),
              ],
            ),
          ),
        );
      case OrderType.ONSITE:
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: const Color(0xffEFEBE9),
            appBar: AppBar(
              title: const Text("Take Away Order Today"),
              backgroundColor: Colors.white,
              centerTitle: true,
              bottom: TabBar(
                  padding: EdgeInsets.zero,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  unselectedLabelColor: AppColor.disableColor,
                  indicatorColor: AppColor.primaryColor,
                  labelColor: AppColor.primaryColor,
                  tabs: OrderStatusExtension.orderStatusOnSiteProcessing()
                      .map((e) => Tab(
                            child: Text(
                              e,
                              style: AppStyle.mediumTextStyleDark,
                            ),
                          ))
                      .toList()),
            ),
            body: TabBarView(
              children: [
                OrderInformationList(
                    orderType: orderType, orderStatus: OrderStatus.CREATED),
                OrderInformationList(
                  orderType: orderType,
                  orderStatus: OrderStatus.ACCEPTED,
                ),
                OrderInformationList(
                  orderType: orderType,
                  orderStatus: OrderStatus.PREPARED,
                ),
                OrderInformationList(
                    orderType: orderType,
                    orderStatus: OrderStatus.CANCELLATION_REQUEST),
              ],
            ),
          ),
        );
    }
  }
}
