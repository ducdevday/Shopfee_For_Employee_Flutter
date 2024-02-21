part of history;

class HistoryPage extends StatelessWidget {
  static const String route = "/history";
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.sl<HistoryBloc>()..add(HistoryLoadInformation()),
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
              if (state is HistoryLoadInProcess) {
                return const HistorySkeletonList();
              } else if (state is HistoryLoadSuccess) {
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
          context.read<HistoryBloc>().add(HistoryLoadInformation(searchQuery: value));
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
              context.read<HistoryBloc>().add(HistoryLoadInformation());
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
