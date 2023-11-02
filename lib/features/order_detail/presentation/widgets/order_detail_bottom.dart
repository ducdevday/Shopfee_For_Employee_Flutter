import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/bloc/order_detail_bloc.dart';

import 'reason_cancel_sheet.dart';

class OrderDetailBottom extends StatelessWidget {
  final String orderId;

  const OrderDetailBottom({
    super.key,
    required this.orderId,
  });

  Future<void> buildShowReasonCancelSheet(
      BuildContext context, String orderId) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<OrderDetailBloc>(),
          child: ReasonCancelSheet(
            orderId: orderId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoaded) {
          if (state.currentOrderStatus != OrderStatus.SUCCEED &&
              state.currentOrderStatus != OrderStatus.CANCELED) {
            return BottomAppBar(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: AppDimen.screenPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<OrderDetailBloc>().add(AddEventLog(
                                id: orderId,
                                eventLog: EventLogEntity(
                                    orderStatus: state.nextOrderStatus,
                                    time: DateTime.now(),
                                    description: null)));
                          },
                          style: AppStyle.elevatedButtonStylePrimary.copyWith(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40)))),
                          child: Text(OrderStatus.orderStatusAction(
                              state.currentOrderStatus)!),
                        ),
                      ),
                      Builder(builder: (context) {
                        if (state.currentOrderStatus == OrderStatus.CREATED) {
                          return GestureDetector(
                            onTap: () {
                              buildShowReasonCancelSheet(context, orderId);
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cancel,
                                        color: AppColor.paragraphColor,
                                      ),
                                      Text(
                                        "Cancel",
                                        style: AppStyle.normalTextStyleDark,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                    ],
                  ),
                ));
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}
