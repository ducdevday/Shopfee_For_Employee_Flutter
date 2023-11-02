import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_confirm_dialog.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/bloc/order_detail_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryInformation extends StatelessWidget {
  const DeliveryInformation({Key? key}) : super(key: key);

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Delivery Address",
                    style: AppStyle.mediumTitleStyleDark.copyWith(
                        color: AppColor.headingColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_circle_outlined,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          state.orderDetail.address!.recipientName!,
                          style: AppStyle.mediumTextStyleDark
                              .copyWith(color: AppColor.headingColor),
                        ),
                        Text(
                          "  |  ",
                          style: AppStyle.normalTextStyleDark,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext contextDialog) =>
                                    MyConfirmDialog(
                                        title: "Call to",
                                        content: "+84 ${state.orderDetail.address!.phoneNumber!.substring(1)}",
                                        callbackOK: () async {
                                          await _makePhoneCall(
                                              "tel:+84 ${state.orderDetail.address!.phoneNumber!.substring(1)}");
                                          Navigator.pop(contextDialog);
                                        },
                                        callbackCancel: () {
                                          Navigator.pop(contextDialog);
                                        }));
                          },
                          child: Text(
                            state.orderDetail.address!.phoneNumber!,
                            style: AppStyle.normalTextStyleDark.copyWith(
                                decoration: TextDecoration.underline,
                                color: AppColor.info),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      state.orderDetail.address!.details!,
                      style: AppStyle.normalTextStyleDark,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
