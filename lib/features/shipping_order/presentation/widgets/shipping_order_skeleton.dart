import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'shipping_skeleton_item.dart';

class ShippingOrderSkeleton extends StatelessWidget {
  const ShippingOrderSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 10),
        itemCount: 10,
        itemBuilder: (context, index) =>
            ShippingSkeletonItem(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
