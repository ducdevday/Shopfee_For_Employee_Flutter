import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_error.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_loading.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/bloc/order_detail_bloc.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/cancel_detail.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/delivery_infomation.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/note.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/order_detail_bottom.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/order_information.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/payment_summary.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/product_list.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/widgets/tracking_information.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;

  const OrderDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.sl<OrderDetailBloc>()
        ..add(LoadOrderDetail(id: orderId)),
      child: BlocConsumer<OrderDetailBloc, OrderDetailState>(
        listener: (context, state) {
          if (state is OrderDetailFinished) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is OrderDetailLoading) {
            return MyLoading();
          } else if (state is OrderDetailLoaded) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Order Detail"),
                  centerTitle: true,
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(1),
                    child: Divider(height: 1),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimen.screenPadding),
                    child: Column(
                      children: [
                        const TrackingInformation(),
                        Container(
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
                              const DeliveryInformation(),
                              Container(
                                height: 4,
                                color: const Color(0xffEFEBE9),
                              ),
                              const ProductList(),
                              Container(
                                height: 4,
                                color: const Color(0xffEFEBE9),
                              ),
                              const PaymentSummary(),
                              const Note(),
                              const CancelDetail(),
                            ],
                          ),
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
                ),
                bottomNavigationBar: OrderDetailBottom(orderId: orderId));
          } else if (state is OrderDetailError) {
            return MyError();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}


