part of refund;

class RefundDetailWidget extends StatelessWidget {
  final String orderId;

  const RefundDetailWidget({super.key, required this.orderId});

  Widget buildMediaWidget(RefundMediaEntity media) {
    if (media.mediaType == MediaType.VIDEO) {
      return RefundNetworkVideoWidget(url: media.url!);
    } else {
      return RefundNetworkImageWidget(url: media.url!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefundBloc, RefundState>(
      builder: (context, state) {
        if (state is RefundLoadDetailSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RefundStatusWidget(status: state.refundDetail.status),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Text(
                        "Problem with order",
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.refundDetail.reason}",
                            style: AppStyle.normalTextStyleDark,
                          ),
                          Divider(),
                        ],
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Text(
                        "Uploaded Image or video",
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Wrap(
                        spacing: AppDimen.spacing,
                        runSpacing: AppDimen.spacing,
                        children: [
                          ...?state.refundDetail.mediaList
                              ?.map((e) => buildMediaWidget(e)),
                        ],
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Text(
                        "Note",
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.spacing,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        initialValue: state.refundDetail.note,
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            focusedErrorBorder:
                                AppStyle.outlineInputBorderDefault,
                            errorBorder: AppStyle.outlineInputBorderDefault,
                            enabledBorder: AppStyle.outlineInputBorderDefault,
                            focusedBorder: AppStyle.outlineInputBorderPrimary,
                            disabledBorder: AppStyle.outlineInputBorderDefault,
                            hintText: "Type some text",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
              buildRefundActionWidget(context, state.refundDetail.status)
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  SizedBox buildRefundActionWidget(BuildContext context, RefundStatus status) {
    if (status == RefundStatus.PENDING) {
      return SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<RefundBloc>()
                      .add(RefundRejectButtonPressed(orderId: orderId));
                },
                child: Text("Reject"),
                style: AppStyle.elevatedButtonStyleSecondary,
              ),
            ),
            SizedBox(
              width: AppDimen.spacing,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<RefundBloc>()
                      .add(RefundAcceptButtonPressed(orderId: orderId));
                },
                child: Text("Accept"),
                style: AppStyle.elevatedButtonStylePrimary,
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }
}
