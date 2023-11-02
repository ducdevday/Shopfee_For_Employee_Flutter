import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/router/app_router.dart';
import 'package:shopfeeforemployee/features/home/presentation/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.sl<HomeBloc>()..add(LoadHome()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.accountRoute);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/img_default_user.png",
                                ))),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        state.employeeEntity.fullName,
                        style: AppStyle.mediumTitleStyleDark,
                      )
                    ],
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
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.screenPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Image.asset(
                            "assets/images/img_logo_employee.png",
                            width: 220,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRouter.shippingOrderRoute);
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    side: BorderSide(
                                        color: Color(0xfff5f5f5), width: 2)),
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
                                              "assets/icons/ic_shipping_order.png",
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
                                                    color:
                                                        AppColor.headingColor,
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
                                // Navigator.pushNamed(
                                //     context, AppRouter.shippingOrder);
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    side: BorderSide(
                                        color: Color(0xfff5f5f5), width: 2)),
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
                                              "assets/icons/ic_takeaway_order.png",
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
                                                    color:
                                                        AppColor.headingColor,
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
                                Navigator.pushNamed(
                                    context, AppRouter.shippingOrderRoute);
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    side: BorderSide(
                                        color: Color(0xfff5f5f5), width: 2)),
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
                                            padding: const EdgeInsets.only(top: 26, right: 30, bottom: 26, left: 26),
                                            child: Image.asset(
                                              "assets/icons/ic_history_employee.png",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text("History",
                                            style: AppStyle.mediumTextStyleDark
                                                .copyWith(
                                                    color:
                                                        AppColor.headingColor,
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
                                // Navigator.pushNamed(
                                //     context, AppRouter.shippingOrder);
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    side: BorderSide(
                                        color: Color(0xfff5f5f5), width: 2)),
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
                                              "assets/icons/ic_takeaway_order.png",
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
                                                    color:
                                                        AppColor.headingColor,
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
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
