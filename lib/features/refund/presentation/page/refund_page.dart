part of refund;

class RefundPage extends StatefulWidget {
  static const String route = "/refund";
  final String orderId;

  const RefundPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  late final RefundBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<RefundBloc>();
    _bloc.add(RefundLoadDetail(orderId: widget.orderId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: RefreshConfiguration.copyAncestor(
        context: context,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text("Refund Request"),
              centerTitle: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: BlocConsumer<RefundBloc, RefundState>(
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state) {
                    case RefundLoadDetailSuccess():
                      return RefundDetailWidget(
                        orderId: widget.orderId,
                      );
                    case RefundLoadDetailFailure():
                      return MyErrorWidget();
                    default:
                      return SizedBox();
                  }
                },
              ),
            )),
      ),
    );
  }
}
