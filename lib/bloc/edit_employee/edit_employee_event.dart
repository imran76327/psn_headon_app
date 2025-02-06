part of 'edit_employee_bloc.dart';
abstract class EmployeePostEvent {}

class EmployeePost extends EmployeePostEvent {
  final String employeeId;
  final String companyId;
  final String email;
  final String address;
  final String city;
  final String pincode;
  final String? SelectedstateId;

  EmployeePost({
    required this.employeeId,
    required this.companyId,
    required this.email,
    required this.address,
    required this.city,
    required this.pincode,
    required this.SelectedstateId
  });
}
