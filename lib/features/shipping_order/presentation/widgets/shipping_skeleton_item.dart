import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_skelton.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';

class ShippingSkeletonItem extends StatelessWidget {
  const ShippingSkeletonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppDimen.spacing, bottom: 5),
      color: Colors.black38,
      child: const Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppDimen.screenPadding),
                child: Row(
                  children: [
                    MySkeleton(
                      width: 20,
                      height: 20,
                      isCircle: true,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    MySkeleton(width: 60, height: 20),
                  ],
                ),
              ),
              Divider(
                height: 10,
                indent: AppDimen.screenPadding,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppDimen.spacing),
                child: Row(children: [
                  MySkeleton(width: 70, height: 70),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MySkeleton(width: 40, height: 20,)
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            MySkeleton(width: 60, height: 20,)
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        MySkeleton(width: 60, height: 10,),
                        SizedBox(
                          height: 4,
                        ),
                        MySkeleton(width: 60, height: 20,)
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Divider(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Align(alignment: Alignment.centerRight,child: MySkeleton(width: 80, height: 40,)),
          )
        ],
      ),
    );
  }
}
