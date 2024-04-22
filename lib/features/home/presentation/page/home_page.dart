part of home;

class HomePage extends StatelessWidget {
  static const String route = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AccountPage.route);
          },
          child: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              if (state is EmployeeLoadSuccess) {
                return Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                AppPath.imgDefaultAvatar,
                              ))),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      state.employee.fullName,
                      style: AppStyle.mediumTitleStyleDark,
                    )
                  ],
                );
              } else {
                return Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                AppPath.imgDefaultAvatar,
                              ))),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "",
                      style: AppStyle.mediumTitleStyleDark,
                    )
                  ],
                );
              }
            },
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.notifications_none_outlined),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgPicture.asset(
                    AppPath.icCoffeeShop,
                    width: 220,
                  ),
                ),
                Text(
                  "Shopfee For Employee",
                  style: AppStyle.largeTitleStyleDark,
                ),
                const SizedBox(
                  height: AppDimen.spacing,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationUtil.pushNamed(OrdersPage.route,
                            arguments: OrderType.SHIPPING);
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            side:
                                BorderSide(color: Color(0xfff5f5f5), width: 2)),
                        elevation: 0.25,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 27.0,
                                        top: 20,
                                        right: 20,
                                        bottom: 20),
                                    child: Image.asset(
                                      AppPath.icShoppingOrder,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text("Delivery Order",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 1.2)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationUtil.pushNamed(OrdersPage.route,
                            arguments: OrderType.ONSITE);
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            side:
                                BorderSide(color: Color(0xfff5f5f5), width: 2)),
                        elevation: 0.25,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0,
                                        top: 20,
                                        right: 20,
                                        bottom: 20),
                                    child: Image.asset(
                                      AppPath.icTakeAwayOrder,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text("Take Away Order",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 1.2)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, HistoryPage.route);
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            side:
                                BorderSide(color: Color(0xfff5f5f5), width: 2)),
                        elevation: 0.25,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 26,
                                        right: 30,
                                        bottom: 26,
                                        left: 26),
                                    child: Image.asset(
                                      AppPath.icHistoryEmployee,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text("History",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 1.2)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AccountPage.route);
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            side:
                                BorderSide(color: Color(0xfff5f5f5), width: 2)),
                        elevation: 0.25,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 26.0,
                                        top: 26,
                                        right: 26,
                                        bottom: 26),
                                    child: Image.asset(
                                      AppPath.icProfile,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text("Profile",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 1.2)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
