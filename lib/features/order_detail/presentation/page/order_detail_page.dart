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
      ..add(LoadOrderDetail(orderId: widget.orderId));
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
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(1),
                    child: Divider(height: 1),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimen.screenPadding),
                    child: Column(
                      children: [
                        const TrackingInformation(),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffefebe9)),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              const OrderInformation(),
                              Container(
                                height: 4,
                                color: const Color(0xffEFEBE9),
                              ),
                              const DeliveryInformation(),
                              Container(
                                height: 4,
                                color: const Color(0xffEFEBE9),
                              ),
                              const ProductList(),
                              Container(
                                height: 4,
                                color: const Color(0xffEFEBE9),
                              ),
                              const PaymentSummary(),
                              const Note(),
                              const CancelDetail(),
                            ],
                          ),
                        ),
                        // SizedBox(height: 20),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       Navigator.pushNamed(context, "/review",
                        //           arguments: orderId);
                        //     },
                        //     child: Text(
                        //       "Review",
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //         backgroundColor:
                        //             AppColor.primaryColorBackground,
                        //         foregroundColor: AppColor.primaryColor,
                        //         disabledBackgroundColor:
                        //             const Color(0xffCACACA),
                        //         disabledForegroundColor: AppColor.lightColor,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(16))))
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: OrderDetailBottom(orderId: widget.orderId));
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
