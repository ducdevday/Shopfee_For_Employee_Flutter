import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/utils/converter_util.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/bloc/order_detail_bloc.dart';

class CancelDetail extends StatelessWidget {
  const CancelDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoaded &&
            state.currentOrderStatus == OrderStatus.CANCELED) {
          return Column(
            children: [
              Container(
                height: 4,
                color: const Color(0xffEFEBE9),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Canceled Detail",
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Request By",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          state.eventLogs.last.makerByEmployee!
                              ? "Employee"
                              : "User",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Request at",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "${ConverterUtil.formattedTime(state.eventLogs.last.time!)} ${ConverterUtil.formattedDate2(state.eventLogs.last.time!)}",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reason",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "${state.eventLogs.last.description}",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
