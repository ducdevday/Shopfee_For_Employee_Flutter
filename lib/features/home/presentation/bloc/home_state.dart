part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState{
  final EmployeeEntity employeeEntity;

  HomeLoaded({required this.employeeEntity});
  @override
  List<Object> get props => [];
}