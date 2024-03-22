part of orders;

class OrderInformationList extends StatefulWidget {
  final OrderType orderType;
  final OrderStatus orderStatus;

  const OrderInformationList(
      {Key? key, required this.orderStatus, required this.orderType})
      : super(key: key);

  @override
  State<OrderInformationList> createState() => _OrderInformationListState();
}

class _OrderInformationListState extends State<OrderInformationList> {
  late final OrdersBloc _bloc;
  late final ScrollController scrollController;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<OrderInformationEntity> orderList;

  int initPage = 1;
  int initSize = 8;

  @override
  void initState() {
    super.initState();
    print("OrderInformationList initState");
    _bloc = ServiceLocator.sl<OrdersBloc>()
      ..add(OrderLoadInformation(
          orderType: widget.orderType,
          orderStatus: widget.orderStatus,
          initPage: initPage,
          initSize: initSize));
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
      _bloc.add(OrderLoadMoreInformation(
          orderType: widget.orderType, orderStatus: widget.orderStatus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state is ShippingOrderLoadSuccess) {
            isLoadingMore = state.isLoadMore;
            cannotLoadMore = state.cannotLoadMore;
            orderList = state.orderList;
          }
        },
        builder: (context, state) {
          if (state is OrdersLoadInProcess) {
            return const OrderSkeletonList();
          } else if (state is ShippingOrderLoadSuccess) {
            if (orderList.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<OrdersBloc>().add(OrderLoadInformation(
                      orderType: widget.orderType,
                      orderStatus: widget.orderStatus,
                      initPage: initPage,
                      initSize: initSize));
                },
                child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 10),
                  itemCount:
                      isLoadingMore ? orderList.length + 1 : orderList.length,
                  itemBuilder: (context, index) {
                    if (index < orderList.length) {
                      return OrderInformationItem(order: orderList[index]);
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
                      AppPath.icNoOrder,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      widget.orderStatus.getEmptyOrderStatusList(),
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

// @override
// bool get wantKeepAlive => true;
}
