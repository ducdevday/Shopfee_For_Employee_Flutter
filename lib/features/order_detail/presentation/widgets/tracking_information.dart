part of order_detail;

class TrackingInformation extends StatefulWidget {
  const TrackingInformation({Key? key}) : super(key: key);

  @override
  State<TrackingInformation> createState() => _TrackingInformationState();
}

class _TrackingInformationState extends State<TrackingInformation> {
  String getTrackingImage(OrderStatus status, OrderStatus currentStatus) {
    if (status == OrderStatus.CREATED) {
      return AppPath.icStatusCreated;
    } else if (status == OrderStatus.ACCEPTED) {
      if (currentStatus == OrderStatus.CANCELED) {
        return AppPath.icStatusCanceled;
      }
      return AppPath.icStatusAccepted;
    } else if (status == OrderStatus.DELIVERING) {
      return AppPath.icStatusDelivering;
    } else if (status == OrderStatus.SUCCEED) {
      return AppPath.icStatusSucceed;
    } else {
      return AppPath.icStatusCanceled;
    }
  }

  Color getTrackingColor(
      int index, int currentIndex, OrderStatus currentStatus) {
    if (currentStatus == OrderStatus.CANCELED) {
      currentIndex = 1;
    }
    if (index == currentIndex) {
      if (currentStatus == OrderStatus.CANCELED) {
        return AppColor.error;
      }
      return AppColor.inProgressColor;
    } else if (index < currentIndex) {
      return AppColor.completeColor;
    } else {
      return AppColor.todoColor;
    }
  }

  String getTrackingName(OrderStatus status, OrderStatus currentStatus) {
    if (status == OrderStatus.CREATED) {
      return status.name;
    } else if (status == OrderStatus.ACCEPTED) {
      if (currentStatus == OrderStatus.CANCELED) {
        return status.name;
      }
      return status.name;
    } else if (status == OrderStatus.DELIVERING) {
      return status.name;
    } else if (status == OrderStatus.SUCCEED) {
      return status.name;
    } else {
      return status.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoadSuccess) {
          return SizedBox(
            height: 175,
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: const ConnectorThemeData(
                  space: 30.0,
                  thickness: 5.0,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemExtentBuilder: (_, __) =>
                    (MediaQuery.of(context).size.width -
                        AppDimen.screenPadding * 2) /
                    state.ordersTracking.length,
                oppositeContentsBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      getTrackingImage(state.ordersTracking[index],
                          state.currentOrderStatus!),
                      width: 50.0,
                      color: getTrackingColor(
                          index, state.currentIndex!, state.currentOrderStatus!),
                    ),
                  );
                },
                contentsBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Text(
                          getTrackingName(state.ordersTracking[index],
                              state.currentOrderStatus!),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: getTrackingColor(index, state.currentIndex!,
                                state.currentOrderStatus!),
                          ),
                        ),
                        Builder(builder: (context) {
                          if (state.eventLogs.asMap().containsKey(index)) {
                            return Column(
                              children: [
                                Text(
                                  FormatUtil.formatTime(
                                      state.eventLogs[index].time!),
                                  style: TextStyle(
                                    color: getTrackingColor(
                                        index,
                                        state.currentIndex!,
                                        state.currentOrderStatus!),
                                  ),
                                ),
                                Text(
                                  FormatUtil.formatDate2(
                                      state.eventLogs[index].time!),
                                  style: TextStyle(
                                    color: getTrackingColor(
                                        index,
                                        state.currentIndex!,
                                        state.currentOrderStatus!),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        })
                      ],
                    ),
                  );
                },
                indicatorBuilder: (_, index) {
                  // var color;
                  // var child;
                  // if (index == _processIndex) {
                  //   color = inProgressColor;
                  // child = Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: CircularProgressIndicator(
                  //     strokeWidth: 3.0,
                  //     valueColor: AlwaysStoppedAnimation(Colors.white),
                  //   ),
                  // );
                  //} else if (index < _processIndex) {
                  // color = completeColor;
                  // child = Icon(
                  //   Icons.check,
                  //   color: Colors.white,
                  //   size: 15.0,
                  // );
                  // } else {
                  // color = todoColor;
                  // }
                  return Stack(
                    children: [
                      OutlinedDotIndicator(
                        borderWidth: 4.0,
                        color: getTrackingColor(index, state.currentIndex!,
                            state.currentOrderStatus!),
                      ),
                    ],
                  );
                },
                connectorBuilder: (_, index, type) {
                  if (index > 0) {
                    if (index == state.currentIndex) {
                      final prevColor = getTrackingColor(index - 1,
                          state.currentIndex!, state.currentOrderStatus!);
                      final color = getTrackingColor(
                          index, state.currentIndex!, state.currentOrderStatus!);
                      List<Color> gradientColors;
                      if (type == ConnectorType.start) {
                        gradientColors = [
                          Color.lerp(prevColor, color, 0.5)!,
                          color
                        ];
                      } else {
                        gradientColors = [
                          prevColor,
                          Color.lerp(prevColor, color, 0.5)!
                        ];
                      }
                      return DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                        ),
                      );
                    } else {
                      return SolidLineConnector(
                        color: getTrackingColor(index, state.currentIndex!,
                            state.currentOrderStatus!),
                      );
                    }
                  } else {
                    return null;
                  }
                },
                itemCount: state.ordersTracking.length,
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
