part of statistics;

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final StatisticsUseCase _statisticsUseCase;

  StatisticBloc(this._statisticsUseCase) : super(StatisticInitial()) {
    on<StatisticLoadInformationByDate>(_onStatisticLoadInformationByDate);
  }

  FutureOr<void> _onStatisticLoadInformationByDate(
      StatisticLoadInformationByDate event,
      Emitter<StatisticState> emit) async {
    try {
      EasyLoading.show();
      final saleData = await _statisticsUseCase.getSaleStatistic(
          SharedService.getEmployeeId()!,
          FormatUtil.formattedStatisticDatetimeToString(event.dateTimes[0]!),
          FormatUtil.formattedStatisticDatetimeToString(event.dateTimes[1]!));
      EasyLoading.dismiss();
      emit(StatisticLoadSuccess(saleData: saleData));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
