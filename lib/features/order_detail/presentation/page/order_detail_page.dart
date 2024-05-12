part of order_detail;

class OrderDetailPage extends StatefulWidget {
  static const String route = "/order_detail";
  final String orderId;

  const OrderDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late final OrderDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<OrderDetailBloc>()
      ..add(OrderDetailLoadInformation(
          orderId: widget.orderId, haveChanged: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<OrderDetailBloc, OrderDetailState>(
        listener: (context, state) {
          if (state is OrderDetailFinished) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is OrderDetailLoadInProcess) {
            return MyLoading();
          } else if (state is OrderDetailLoadSuccess) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Order Detail"),
                  centerTitle: true,
                  automaticallyImplyLeading: true,
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(1),
                    child: Divider(height: 1),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: AppDimen.spacing),
                      child: InkWell(onTap: () {
                          NavigationUtil.pushNamed(PosPage.route, arguments: state.orderDetail);
                      }, child: Icon(Icons.print_outlined)),
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const OrderInformation(),
                      Container(
                        height: 4,
                        color: const Color(0xffEFEBE9),
                      ),
                      const TrackingInformation(),
                      Container(
                        height: 4,
                        color: const Color(0xffEFEBE9),
                      ),
                      const DeliveryInformation(),
                      const TakeAwayInformation(),
                      Container(
                        height: 4,
                        color: const Color(0xffEFEBE9),
                      ),
                      const Note(),
                      const ProductList(),
                      Container(
                        height: 4,
                        color: const Color(0xffEFEBE9),
                      ),
                      const PaymentSummary(),
                      const CancelDetail(),
                    ],
                  ),
                ),
                bottomNavigationBar:
                    OrderDetailBottom(orderId: widget.orderId));
          } else if (state is OrderDetailLoadFailure) {
            return MyError();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
