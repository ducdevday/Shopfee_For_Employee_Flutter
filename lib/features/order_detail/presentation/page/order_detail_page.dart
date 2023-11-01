import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_error.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_loading.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/bloc/order_detail_bloc.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/order_information.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/payment_summary.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/product_list.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;

  const OrderDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.sl<OrderDetailBloc>()
        ..add(LoadOrderDetail(id: orderId)),
      child: Scaffold(
        body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
          builder: (context, state) {
            if (state is OrderDetailLoading) {
              return const MyLoading();
            } else if (state is OrderDetailLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppDimen.screenPadding,
                      right: AppDimen.screenPadding,
                      bottom: AppDimen.screenPadding),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: AppDimen.screenPadding * 2,
                              bottom: AppDimen.screenPadding),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close_rounded),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffefebe9)),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                const OrderInformation(),
                                Container(
                                  height: 4,
                                  color: const Color(0xffEFEBE9),
                                ),
                                // DeliveryInformation(),
                                // Container(
                                //   height: 4,
                                //   color: const Color(0xffEFEBE9),
                                // ),
                                const ProductList(),
                                Container(
                                  height: 4,
                                  color: const Color(0xffEFEBE9),
                                ),
                                const PaymentSummary(),
                              ],
                            ),
                          ),
                          Center(
                              child: SvgPicture.asset(
                                  "assets/icons/ic_success.svg")),
                        ],
                      ),
                      // SizedBox(height: 20),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, "/review",
                      //           arguments: orderId);
                      //     },
                      //     child: Text(
                      //       "Review",
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor:
                      //             AppColor.primaryColorBackground,
                      //         foregroundColor: AppColor.primaryColor,
                      //         disabledBackgroundColor:
                      //             const Color(0xffCACACA),
                      //         disabledForegroundColor: AppColor.lightColor,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(16))))
                    ],
                  ),
                ),
              );
            } else {
              return const MyError();
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<OrderDetailBloc, OrderDetailState>(
          builder: (context, state) {
            if (state is OrderDetailLoaded) {
              return BottomAppBar(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: AppDimen.screenPadding),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: const Text("Empty"),
                    ),
                  ));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
