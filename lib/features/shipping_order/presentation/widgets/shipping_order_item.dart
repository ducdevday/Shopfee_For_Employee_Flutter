import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';

class ShippingOrderItem extends StatelessWidget {
  const ShippingOrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
            child: Row(children: [
              SvgPicture.asset(
                "assets/icons/ic_take_away.svg",
                width: 70,
                height: 70,),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product 1",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(
                          color: AppColor.headingColor,
                          height: 2),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "12:00AM - 29/10/2023",
                      style: AppStyle.normalTextStyleDark,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Column(
                children: [
                  Text(
                    "100,000đ",
                    style: AppStyle.mediumTextStyleDark
                        .copyWith(
                        color: AppColor.headingColor,
                        height: 2),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Created",
                    style: AppStyle.mediumTextStyleDark
                        .copyWith(color: AppColor.primaryColor),
                  ),
                ],
              )
            ]),
          ),
          Divider(height: 2,),
          Text("Show more products", style: AppStyle.smallTextStyleDark,)
        ],
      ),
    );
  }
}
