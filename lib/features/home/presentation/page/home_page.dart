part of home;

class HomePage extends StatefulWidget {
  static const String route = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _socketMethod = ServiceLocator.sl<SocketMethod>();
  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(EmployeeLoadInformation());
    _socketMethod.joinBranch(branchId: SharedService.getBranchId()!);
  }
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
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 8.0),
          //   child: GestureDetector(
          //       onTap: () {
          //       },
          //       child: Icon(Icons.notifications_none_outlined)),
          // )
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
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          NavigationUtil.pushNamed(OrdersPage.route,
                              arguments: OrderType.SHIPPING);
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              side: BorderSide(
                                  color: Color(0xfff5f5f5), width: 2)),
                          elevation: 0.25,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.all(16),
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
                                Text("Delivery Order",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 1.2)),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          NavigationUtil.pushNamed(OrdersPage.route,
                              arguments: OrderType.ONSITE);
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              side: BorderSide(
                                  color: Color(0xfff5f5f5), width: 2)),
                          elevation: 0.25,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.all(16),
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
                                Text("Take Away Order",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 1.2)),
                                const SizedBox(
                                  height: 16,
                                ),
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
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, HistoryPage.route);
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              side: BorderSide(
                                  color: Color(0xfff5f5f5), width: 2)),
                          elevation: 0.25,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.all(16.0),
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
                                Text("History",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 1.2)),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AccountPage.route);
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              side: BorderSide(
                                  color: Color(0xfff5f5f5), width: 2)),
                          elevation: 0.25,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  margin: const EdgeInsets.all(16.0),
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
                                Text("Profile",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 1.2)),
                                const SizedBox(
                                  height: 16,
                                ),
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
