import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';
import 'package:shopfeeforemployee/features/history/presentation/bloc/history_bloc.dart';
import 'package:shopfeeforemployee/features/history/presentation/widgets/history_item.dart';

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

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.orderStatus == OrderStatus.SUCCEED) {
        context.read<HistoryBloc>().add(const LoadHistorySucceed());
      } else {
        context.read<HistoryBloc>().add(const LoadHistoryCanceled());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoaded) {
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
                context.read<HistoryBloc>().add(InitHistory());
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


