part of 'edit_employee_bloc.dart';
abstract class EmployeePostState {}

class EmployeePostInitial extends EmployeePostState {}

class EmployeePostLoading extends EmployeePostState {}

class EmployeePostSuccess extends EmployeePostState {
  final String messages;
  EmployeePostSuccess(this.messages);

  String get message => "Update Successfully";

}

class EmployeePostFailure extends EmployeePostState {
  final String error;

  EmployeePostFailure(this.error, {required bool errorLoading});

  String get message => "Failed to  update";
}
