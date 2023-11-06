import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfeeforemployee/features/history/presentation/widgets/history_skeleton_item.dart';

class HistorySkeletonList extends StatelessWidget {
  const HistorySkeletonList({
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
            HistorySkeletonItem(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
