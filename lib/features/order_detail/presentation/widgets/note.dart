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
          return Column(
            children: [
              Container(
                height: 4,
                color: Color(0xffEFEBE9),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Note",
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      initialValue: state.orderDetail.note,
                      enabled: false,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}