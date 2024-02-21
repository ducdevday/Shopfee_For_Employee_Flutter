part of employee;

abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeLoadInProcess extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeLoadSuccess extends EmployeeState {
  final EmployeeEntity employee;

  const EmployeeLoadSuccess({
    required this.employee,
  });

  @override
  List<Object> get props => [employee];

  EmployeeLoadSuccess copyWith({
    EmployeeEntity? employee,
  }) {
    return EmployeeLoadSuccess(
      employee: employee ?? this.employee,
    );
  }
}

class EmployeeLoadFailure extends EmployeeState {
  @override
  List<Object> get props => [];
}
