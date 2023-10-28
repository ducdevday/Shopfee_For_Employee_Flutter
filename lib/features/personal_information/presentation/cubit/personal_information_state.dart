part of 'personal_information_cubit.dart';

abstract class PersonalInformationState extends Equatable {
  const PersonalInformationState();
}

class PersonalInformationInitial extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationLoaded extends PersonalInformationState {
  final EmployeeEntity employee;

  const PersonalInformationLoaded({required this.employee});

  @override
  List<Object> get props => [employee];
}

class PersonalInformationFinished extends PersonalInformationState {
  @override
  List<Object> get props => [];
}
