part of history;

class HistoryListView extends StatefulWidget {
  final OrderStatus orderStatus;

  const HistoryListView({Key? key, required this.orderStatus}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final scrollController = ScrollController();
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<HistoryEntity> historyList;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.orderStatus == OrderStatus.SUCCEED) {
        context.read<HistoryBloc>().add(const HistoryLoadSucceedOrder());
      } else {
        context.read<HistoryBloc>().add(const HistoryLoadCanceledOrder());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoadSuccess) {
          if (widget.orderStatus == OrderStatus.SUCCEED) {
            isLoadingMore = state.isSucceedLoadMore;
            cannotLoadMore = state.cannotSucceedLoadMore;
            historyList = state.historiesSucceed;
          } else {
            isLoadingMore = state.isCanceledLoadMore;
            cannotLoadMore = state.cannotCanceledLoadMore;
            historyList = state.historiesCanceled;
          }
          if (historyList.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HistoryBloc>().add(HistoryLoadInformation());
              },
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.only(top: 10),
                itemCount:
                    isLoadingMore ? historyList.length + 1 : historyList.length,
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
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.orderStatus == OrderStatus.SUCCEED ? "No Succeed Orders Yet" : "No Canceled Orders Yet",
                    style: AppStyle.mediumTextStyleDark
                        .copyWith(color: AppColor.nonactiveColor),
                  )
                ],
              ),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}


