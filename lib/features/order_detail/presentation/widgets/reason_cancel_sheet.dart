import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_confirm_dialog.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/bloc/order_detail_bloc.dart';

final List<String> reasons = const [
  "This product was sold out",
  "Shipper of Shopfee is not available at present",
  "Shopfee is closed today",
  "Other reason"
];

class ReasonCancelSheet extends StatelessWidget {
  final String orderId;

  const ReasonCancelSheet({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoaded) {
          return Wrap(
            // child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close_rounded)),
                  ),
                  Text(
                    "Choose Reason For Cancel",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_rounded))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(child: Text(reasons[index])),
                            const SizedBox(
                              width: 4,
                            ),
                            Radio<String>(
                                activeColor: AppColor.primaryColor,
                                value: reasons[index],
                                groupValue: state.reasonCancel,
                                onChanged: (String? value) {
                                  context
                                      .read<OrderDetailBloc>()
                                      .add(ChooseReasonCancel(reason: value!));
                                })
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        height: 10,
                        indent: 10,
                        endIndent: 10,
                      ),
                  itemCount: reasons.length),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(AppDimen.spacing),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext contextDialog) =>
                              MyConfirmDialog(
                                  title: "Confirm",
                                  content:
                                      "Are you sure to CANCEL this order",
                                  callbackOK: () async {
                                    context.read<OrderDetailBloc>().add(
                                        AddEventLog(
                                            id: orderId,
                                            eventLog: EventLogEntity(
                                                orderStatus:
                                                    OrderStatus.CANCELED,
                                                time: DateTime.now(),
                                                description: state.reasonCancel,
                                                makerByEmployee: true)));
                                    Navigator.pop(contextDialog);
                                  },
                                  callbackCancel: () {
                                    Navigator.pop(contextDialog);
                                  })).then((value) => Navigator.pop(context));
                    },
                    child: const Text("Confirm Cancel"),
                    style: AppStyle.elevatedButtonStylePrimary.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.error)),
                  ))
            ],
            // ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
