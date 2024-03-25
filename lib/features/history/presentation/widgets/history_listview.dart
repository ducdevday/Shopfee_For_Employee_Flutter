part of history;

class HistoryListView extends StatefulWidget {
  final OrderStatus orderStatus;
  final String? searchQuery;

  const HistoryListView(
      {Key? key, required this.orderStatus, required this.searchQuery})
      : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  late HistoryBloc _bloc;
  late ScrollController scrollController;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<HistoryEntity> historyList;

  int initPage = 1;
  int initSize = 8;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<HistoryBloc>()
      ..add(HistoryLoadInformation(
          orderStatus: widget.orderStatus,
          initPage: initPage,
          initSize: initSize,
          searchQuery: widget.searchQuery));
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
      _bloc.add(HistoryLoadMoreInformation(orderStatus: widget.orderStatus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoadInProcess) {
            return const HistorySkeletonList();
          } else if (state is HistoryLoadSuccess) {
            isLoadingMore = state.isLoadMore;
            cannotLoadMore = state.cannotLoadMore;
            historyList = state.historyList;
            if (historyList.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  _bloc.add(HistoryLoadInformation(
                      orderStatus: widget.orderStatus,
                      initPage: initPage,
                      initSize: initSize,
                      searchQuery: widget.searchQuery));
                },
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: isLoadingMore
                      ? historyList.length + 1
                      : historyList.length,
                  itemBuilder: (context, index) {
                    if (index < historyList.length) {
                      return HistoryItem(history: historyList[index]);
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
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/ic_no_order.png",
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      widget.orderStatus == OrderStatus.SUCCEED
                          ? "No Succeed Orders Yet"
                          : "No Canceled Orders Yet",
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.nonactiveColor),
                    )
                  ],
                ),
              );
            }
          } else if(state is HistoryLoadFailure) {
            return const MyErrorWidget();
          }
          return const SizedBox();
        },
      ),
    );
  }
}
