part of orders;

class OrderSkeletonList extends StatelessWidget {
  const OrderSkeletonList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10),
      itemCount: 10,
      itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: OrderSkeletonItem()),
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
    );
  }
}
