part of order_detail;

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess &&
            state.orderDetail.note != null &&
            state.orderDetail.note!.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppPath.icNote,
                  width: AppDimen.mediumSize,
                  height: AppDimen.mediumSize,
                ),
                SizedBox(
                  width: AppDimen.spacing,
                ),
                Expanded(
                  child: Text(
                    "${state.orderDetail.note}",
                    style: AppStyle.normalTextStyleDark,
                  ),
                )
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
