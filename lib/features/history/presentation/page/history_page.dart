import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_error.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(110), // Adj
              child: Column(
                children: [
                  SearchBarHistory(),
                  TabBar(
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
                ],
              ),
            ),
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

class SearchBarHistory extends StatefulWidget {
  const SearchBarHistory({
    super.key,
  });

  @override
  State<SearchBarHistory> createState() => _SearchBarHistoryState();
}

class _SearchBarHistoryState extends State<SearchBarHistory> {
  TextEditingController _controller = TextEditingController();
  bool isEmpty = true;

  void handleSearchChange(String value) {
    if (value.isNotEmpty) {
      setState(() {
        isEmpty = false;
      });
    } else {
      setState(() {
        isEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimen.spacing),
      color: const Color(0xffEFEBE9),
      child: TextField(
        textInputAction: TextInputAction.search,
        style: AppStyle.normalTextStyleDark,
        controller: _controller,
        onChanged: (value) {
          handleSearchChange(value);
        },
        onSubmitted: (value) {
          context.read<HistoryBloc>().add(InitHistory(searchQuery: value));
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: isEmpty ? null : IconButton(
            icon: const FaIcon(FontAwesomeIcons.solidCircleXmark),
            onPressed: () {
              _controller.text = "";
              handleSearchChange("");
              context.read<HistoryBloc>().add(InitHistory());
            },
            iconSize: 16,
            color: AppColor.nonactiveColor,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintText: "Search order ID, Customer name or phone number",
        ),
      ),
    );
  }
}
