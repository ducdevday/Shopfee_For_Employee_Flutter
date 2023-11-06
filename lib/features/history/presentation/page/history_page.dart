import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_error.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_loading.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/features/history/presentation/bloc/history_bloc.dart';
import 'package:shopfeeforemployee/features/history/presentation/widgets/history_listview.dart';
import 'package:shopfeeforemployee/features/history/presentation/widgets/history_skeleton_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.sl<HistoryBloc>()..add(InitHistory()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xffEFEBE9),
          appBar: AppBar(
            title: const Text("History"),
            backgroundColor: Colors.white,
            centerTitle: true,
            bottom: TabBar(
                unselectedLabelColor: AppColor.disableColor,
                indicatorColor: AppColor.primaryColor,
                labelColor: AppColor.primaryColor,
                tabs: OrderStatus.orderStatusFinished()
                    .map((e) => Tab(
                          child: Text(
                            e,
                            style: AppStyle.mediumTextStyleDark,
                          ),
                        ))
                    .toList()),
          ),
          body: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return const HistorySkeletonList();
              } else if (state is HistoryLoaded) {
                return const TabBarView(
                  children: [
                    HistoryListView(orderStatus: OrderStatus.SUCCEED),
                    HistoryListView(orderStatus: OrderStatus.CANCELED),
                  ],
                );
              } else {
                return const MyError();
              }
            },
          ),
        ),
      ),
    );
  }
}
