part of statistics;

class StatisticsPage extends StatefulWidget {
  static const String route = "/statistics";

  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late StatisticBloc _bloc;
  late List<DateTime?> dateTimes;

  @override
  void initState() {
    super.initState();
    dateTimes = [
      CalculateUtil.getDateTime7DaysAgo(),
      FormatUtil.addOneDay(DateTime.now())
    ];

    _bloc = ServiceLocator.sl<StatisticBloc>()
      ..add(StatisticLoadInformationByDate(dateTimes: dateTimes));
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
      child: Scaffold(
          backgroundColor: AppColor.scaffoldColorBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Statistics"),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: BlocBuilder<StatisticBloc, StatisticState>(
                builder: (context, state) {
                  if (state is StatisticLoadSuccess) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Tracking Sale",
                              style: AppStyle.mediumTitleStyleDark,
                            )),
                            InkWell(
                              onTap: () async {
                                var results =
                                    await showCalendarDatePicker2Dialog(
                                  context: context,
                                  config:
                                      CalendarDatePicker2WithActionButtonsConfig(
                                          calendarType:
                                              CalendarDatePicker2Type.range,
                                          centerAlignModePicker: true,
                                          selectedRangeHighlightColor:
                                              AppColor.secondaryColor,
                                          selectedDayHighlightColor:
                                              AppColor.primaryColor,
                                          dayBorderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  AppDimen.smallRadius)),
                                          // firstDate: CalculateUtil
                                          //     .getDateTime31DaysAgo(),
                                          lastDate: DateTime.now(),
                                          currentDate: DateTime.now()),
                                  dialogSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      400),
                                  value: dateTimes,
                                  borderRadius: BorderRadius.circular(15),
                                );
                                if (results != null) {
                                  dateTimes = results;
                                  context.read<StatisticBloc>().add(
                                      StatisticLoadInformationByDate(
                                          dateTimes: results));
                                }
                              },
                              child: MyContainer(
                                child: Row(
                                  children: [
                                    Text(
                                        "${FormatUtil.formatDate3(dateTimes.first)}-${FormatUtil.formatDate3(dateTimes.last)}"),
                                    SizedBox(
                                      width: AppDimen.smallSpacing,
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      size: AppDimen.xSmallSize,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: AppDimen.spacing,
                        ),
                        MyContainer(
                          child: Column(
                            children: [
                              SfCartesianChart(
                                  primaryXAxis: DateTimeAxis(),
                                  trackballBehavior: TrackballBehavior(
                                    activationMode: ActivationMode.singleTap,
                                    enable: true,
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePinching: true,
                                    zoomMode: ZoomMode.x,
                                    enablePanning: true,
                                    enableDoubleTapZooming: true,
                                  ),
                                  series: <CartesianSeries>[
                                    // Renders line chart
                                    LineSeries<ChartLineData, DateTime>(
                                      dataSource:
                                          state.saleData.chartOrderCountData,
                                      xValueMapper: (ChartLineData data, _) =>
                                          data.time,
                                      yValueMapper: (ChartLineData data, _) =>
                                          data.value,
                                    ),
                                  ]),
                              SizedBox(
                                height: AppDimen.spacing,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text("Total Order Count")),
                                  Expanded(
                                      child: Text(
                                    "${state.saleData.totalOrderCount}",
                                    textAlign: TextAlign.end,
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppDimen.spacing,
                        ),
                        MyContainer(
                          child: Column(
                            children: [
                              SfCartesianChart(
                                  primaryXAxis: DateTimeAxis(),
                                  primaryYAxis: NumericAxis(
                                    numberFormat: NumberFormat.currency(
                                        locale: 'vi_VN', symbol: '₫'),
                                  ),
                                  trackballBehavior: TrackballBehavior(
                                    activationMode: ActivationMode.singleTap,
                                    enable: true,
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePinching: true,
                                    zoomMode: ZoomMode.x,
                                    enablePanning: true,
                                    enableDoubleTapZooming: true,
                                  ),
                                  series: <CartesianSeries>[
                                    // Renders line chart
                                    LineSeries<ChartLineData, DateTime>(
                                      //TODO: Marker
                                      // markerSettings:  MarkerSettings(
                                      //     isVisible: true,
                                      //     height: 4,
                                      //     width: 4,
                                      //     shape: DataMarkerType.circle,
                                      //     borderWidth: 3,
                                      //     borderColor: AppColor.primaryColor),
                                      //TODO: Marker Label
                                      // dataLabelSettings:
                                      //     const DataLabelSettings(
                                      //         isVisible: true,
                                      //         labelAlignment:
                                      //             ChartDataLabelAlignment.auto),
                                      dataSource:
                                          state.saleData.chartItemPriceData,
                                      xValueMapper: (ChartLineData data, _) =>
                                          data.time,
                                      yValueMapper: (ChartLineData data, _) =>
                                          data.value,
                                    ),
                                  ]),
                              SizedBox(
                                height: AppDimen.spacing,
                              ),
                              SizedBox(
                                height: AppDimen.spacing,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text("Total Money")),
                                  Expanded(
                                      child: Text(
                                    "${FormatUtil.formatMoney(state.saleData.totalItemPrice)}",
                                    textAlign: TextAlign.end,
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          )),
    );
  }
}
