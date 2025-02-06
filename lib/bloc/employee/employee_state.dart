part of 'employee_bloc.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeError extends EmployeeState {
  final bool errorLoading; // Specifies if this error is related to loading
  final String message;

  const EmployeeError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message];
}

final class EmployeeSuccess extends EmployeeState {
  final EmployeeModal employee;
  final List<StateModal> statelist;

  const EmployeeSuccess(this.employee,this.statelist);

  @override
  List<Object> get props => [employee,statelist];
}
