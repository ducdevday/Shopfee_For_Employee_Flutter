part of 'pos_cubit.dart';

sealed class PosState extends Equatable {
  const PosState();
}

final class PosInitial extends PosState {
  @override
  List<Object> get props => [];
}

final class PosLoadSuccess extends PosState {
  final File orderBillPdf;

  const PosLoadSuccess({
    required this.orderBillPdf,
  });

  @override
  List<Object> get props => [];


}

final class PosLoadFailure extends PosState {
  @override
  List<Object> get props => [];
}