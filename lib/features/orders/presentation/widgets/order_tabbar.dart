part of orders;

class OrderTabBar extends StatelessWidget {
  const OrderTabBar({Key? key}) : super(key: key);

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
