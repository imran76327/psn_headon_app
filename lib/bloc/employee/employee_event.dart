part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}
class EmployeeFetch extends EmployeeEvent {
  final String employeeId;
  final String companyId;

  const EmployeeFetch(this.employeeId, this.companyId);
}