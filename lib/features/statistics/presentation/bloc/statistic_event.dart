part of statistics;

sealed class StatisticEvent extends Equatable {
  const StatisticEvent();
}

class StatisticLoadInformationByDate extends StatisticEvent{
  final List<DateTime?> dateTimes;

  const StatisticLoadInformationByDate({
    required this.dateTimes,
  });

  @override
  List<Object> get props => [dateTimes];
}