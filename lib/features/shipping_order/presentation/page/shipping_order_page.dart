part of shipping_order;

class ShippingOrderPage extends StatelessWidget {
  static const String route = "/shipping_order";

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
              padding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
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
            ShippingOrderList(
                orderStatus: OrderStatus.CREATED,
                emptyTitle: "No Created Orders Yet"),
            ShippingOrderList(
                orderStatus: OrderStatus.ACCEPTED,
                emptyTitle: "No Accepted Orders Yet"),
            ShippingOrderList(
                orderStatus: OrderStatus.DELIVERING,
                emptyTitle: "No Delivering Orders Yet")
          ],
        ),
      ),
    );
  }
}
