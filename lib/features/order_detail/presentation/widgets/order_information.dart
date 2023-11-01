import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/utils/converter_util.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/bloc/order_detail_bloc.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailLoaded) {
            return Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Thank you!",
                  style: AppStyle.largeTitleStylePrimary,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Your order was successful",
                  style: AppStyle.mediumTextStyleDark,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID Transaction",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      state.orderDetailEntity.id!,
                      style: AppStyle.normalTextStyleDark,
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
                      "Date",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      ConverterUtil.formattedDate(
                          state.orderDetailEntity.createdAt!),
                      style: AppStyle.normalTextStyleDark,
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
                      "Time",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      ConverterUtil.formattedTime(
                          state.orderDetailEntity.createdAt!),
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
