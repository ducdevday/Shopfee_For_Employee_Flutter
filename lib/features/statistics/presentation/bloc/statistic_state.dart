part of statistics;

sealed class StatisticState extends Equatable {
  const StatisticState();
}

final class StatisticInitial extends StatisticState {
  @override
  List<Object> get props => [];
}

final class StatisticLoadSuccess extends StatisticState {
  final SaleData saleData;

  const StatisticLoadSuccess({
    required this.saleData,
  });

  @override
  List<Object> get props => [saleData];
}

final class StatisticLoadFailure extends StatisticState {
  @override
  List<Object> get props => [];
}
