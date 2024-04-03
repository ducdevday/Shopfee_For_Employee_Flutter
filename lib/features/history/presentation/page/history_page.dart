part of history;

class HistoryPage extends StatefulWidget {
  static const String route = "/history";

  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ValueNotifier<String?> searchQueryNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                  SearchBarHistory(
                    onSearch: (String? query) {
                      searchQueryNotifier.value = query;
                    },
                  ),
                  TabBar(
                      unselectedLabelColor: AppColor.disableColor,
                      indicatorColor: AppColor.primaryColor,
                      labelColor: AppColor.primaryColor,
                      tabs: OrderStatusExtension.orderStatusFinished()
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
          body: ValueListenableBuilder(
            valueListenable: searchQueryNotifier,
            builder: (BuildContext context, String? searchQuery, Widget? child) {
              return TabBarView(
                children: [
                  HistoryListView(
                    orderStatus: OrderStatus.SUCCEED,
                    searchQuery: searchQuery,
                  ),
                  HistoryListView(
                    orderStatus: OrderStatus.CANCELED,
                    searchQuery: searchQuery,
                  ),
                ],
              );
            },
          )),
    );
  }
}

class SearchBarHistory extends StatefulWidget {
  final Function(String?) onSearch;

  const SearchBarHistory({
    super.key,
    required this.onSearch,
  });

  @override
  State<SearchBarHistory> createState() => _SearchBarHistoryState();
}

class _SearchBarHistoryState extends State<SearchBarHistory> {
  late TextEditingController _controller;
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

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
          widget.onSearch(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: isEmpty
              ? null
              : IconButton(
                  icon: const FaIcon(FontAwesomeIcons.solidCircleXmark),
                  onPressed: () {
                    _controller.text = "";
                    handleSearchChange("");
                    widget.onSearch(null);
                  },
                  iconSize: 16,
                  color: AppColor.nonactiveColor,
                ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintText: "Search order ID, Customer id, name or phone number",
        ),
      ),
    );
  }
}
