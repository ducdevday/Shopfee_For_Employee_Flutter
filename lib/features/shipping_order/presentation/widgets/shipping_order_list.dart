part of shipping_order;

class ShippingOrderList extends StatefulWidget {
  final OrderStatus orderStatus;
  final String emptyTitle;

  const ShippingOrderList(
      {Key? key, required this.orderStatus, required this.emptyTitle})
      : super(key: key);

  @override
  State<ShippingOrderList> createState() => _ShippingOrderListState();
}

class _ShippingOrderListState extends State<ShippingOrderList> {
  late final ShippingOrderBloc _bloc;
  late final ScrollController scrollController;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<ShippingOrderEntity> orderList;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ShippingOrderBloc>()
      ..add(LoadShippingOrder(orderStatus: widget.orderStatus));
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _bloc.close();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _bloc.add(LoadMoreShippingOrder(orderStatus: widget.orderStatus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<ShippingOrderBloc, ShippingOrderState>(
        listener: (context, state) {
          if (state is ShippingOrderLoaded) {
            isLoadingMore = state.isLoadMore;
            cannotLoadMore = state.cannotLoadMore;
            orderList = state.orderList;
          }
        },
        builder: (context, state) {
          if (state is ShippingOrderLoading) {
            return const ShippingOrderSkeleton();
          } else if (state is ShippingOrderLoaded) {
            if (orderList.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ShippingOrderBloc>()
                      .add(LoadShippingOrder(orderStatus: widget.orderStatus));
                },
                child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 10),
                  itemCount:
                      isLoadingMore ? orderList.length + 1 : orderList.length,
                  itemBuilder: (context, index) {
                    if (index < orderList.length) {
                      return ShippingOrderItem(order: orderList[index]);
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(AppDimen.spacing),
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/ic_no_order.png",
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      widget.emptyTitle,
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.nonactiveColor),
                    )
                  ],
                ),
              );
            }
          } else {
            return MyError();
          }
        },
      ),
    );
  }
}
