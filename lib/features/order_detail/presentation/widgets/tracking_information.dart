part of order_detail;

class TrackingInformation extends StatefulWidget {
  const TrackingInformation({Key? key}) : super(key: key);

  @override
  State<TrackingInformation> createState() => _TrackingInformationState();
}

class _TrackingInformationState extends State<TrackingInformation> {
  late final ValueNotifier<bool> showFullTrackingListener;

  @override
  void initState() {
    super.initState();
    showFullTrackingListener = ValueNotifier(false);
  }

  @override
  void dispose() {
    showFullTrackingListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess) {
          final List<EventLogEntity> eventLogs =
              state.eventLogs.reversed.toList();
          final EventLogEntity lastEventLog = state.lastEventLog;
          return Padding(
            padding: const EdgeInsets.all(AppDimen.spacing),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Tracking",
                          style: AppStyle.mediumTitleStyleDark.copyWith(
                              color: AppColor.headingColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showFullTrackingListener.value =
                                !showFullTrackingListener.value;
                          },
                          child: ValueListenableBuilder(
                            valueListenable: showFullTrackingListener,
                            builder: (BuildContext context,
                                bool showFullTracking, Widget? child) {
                              return Text(
                                showFullTracking ? "Less" : "More",
                                style: AppStyle.mediumTextStyleDark,
                              );
                            },
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ValueListenableBuilder(
                  valueListenable: showFullTrackingListener,
                  builder: (BuildContext context, bool showFullTracking,
                      Widget? child) {
                    if (showFullTracking) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppDimen.spacing),
                        child: FixedTimeline.tileBuilder(
                          theme: TimelineThemeData(
                            nodePosition: 0,
                            color: Color(0xff989898),
                            indicatorTheme: IndicatorThemeData(
                              position: 0,
                              size: 12.0,
                            ),
                            connectorTheme: ConnectorThemeData(
                              thickness: 1,
                            ),
                          ),
                          builder: TimelineTileBuilder.connected(
                            connectionDirection: ConnectionDirection.before,
                            itemCount: eventLogs.length,
                            contentsBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${eventLogs[index].orderStatus?.getFormattedName()}",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(color: AppColor.primaryColor),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${FormatUtil.formatTime(eventLogs[index].time)} - ${FormatUtil.formatDate(eventLogs[index].time)}",
                                    style: AppStyle.smallTextStyleDark,
                                  ),
                                ],
                              ),
                            ),
                            indicatorBuilder: (_, index) {
                              if (eventLogs[index].orderStatus !=
                                  OrderStatus.SUCCEED) {
                                return DotIndicator(
                                  color: AppColor.primaryColor,
                                );
                              } else {
                                return DotIndicator(
                                  color: AppColor.primaryColor,
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 10.0,
                                  ),
                                );
                              }
                            },
                            itemExtentBuilder: (_, index) {
                              return index < eventLogs.length - 1 ? 70.0 : 40.0;
                            },
                            connectorBuilder: (_, index, ___) =>
                                DashedLineConnector(
                              color: AppColor.primaryColor,
                              thickness: 1.5,
                              dash: 1,
                              gap: 2,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return child!;
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing),
                    child: FixedTimeline.tileBuilder(
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: Color(0xff989898),
                        indicatorTheme: IndicatorThemeData(
                          position: 0,
                          size: 12.0,
                        ),
                        connectorTheme: ConnectorThemeData(
                          thickness: 1,
                        ),
                      ),
                      builder: TimelineTileBuilder.connected(
                        connectionDirection: ConnectionDirection.before,
                        itemCount: 1,
                        contentsBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${lastEventLog.orderStatus?.getFormattedName()}",
                                style: AppStyle.mediumTextStyleDark
                                    .copyWith(color: AppColor.primaryColor),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${FormatUtil.formatTime(lastEventLog.time)} - ${FormatUtil.formatDate(lastEventLog.time)}",
                                style: AppStyle.smallTextStyleDark,
                              ),
                            ],
                          ),
                        ),
                        indicatorBuilder: (_, index) {
                          if (lastEventLog.orderStatus != OrderStatus.SUCCEED) {
                            return DotIndicator(
                              color: AppColor.primaryColor,
                            );
                          } else {
                            return DotIndicator(
                              color: AppColor.primaryColor,
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10.0,
                              ),
                            );
                          }
                        },
                        connectorBuilder: (_, index, ___) =>
                            DashedLineConnector(
                          color: AppColor.primaryColor,
                          thickness: 1.5,
                          dash: 1,
                          gap: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
