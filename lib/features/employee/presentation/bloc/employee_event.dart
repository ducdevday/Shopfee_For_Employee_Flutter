part of employee;

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class EmployeeLoadInformation extends EmployeeEvent {
  @override
  List<Object> get props => [];
}

class EmployeeLogout extends EmployeeEvent {
  @override
  List<Object> get props => [];
}
