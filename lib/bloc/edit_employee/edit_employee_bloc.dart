import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../services/web_service/web_service_api.dart';

part 'edit_employee_event.dart';
part 'edit_employee_state.dart';

class EmployeePostBloc extends Bloc<EmployeePostEvent, EmployeePostState> {
  EmployeePostBloc() : super(EmployeePostInitial()) {
    on<EmployeePost>(employeeData);
  }

  /// Method that processes the employee data and posts it via the API
  Future<void> employeeData(EmployeePost event, emit) async {
    try {
      WebServiceApi api = WebServiceApi();
      // Pass employeeId, companyId, and other details to postEmployeeDetails
      final Response employeeResponse = await api.postEmployeeDetails(
        employeeId: event.employeeId,
        companyId: event.companyId,
        email: event.email,
        address: event.address,
        city: event.city,
        pincode:event.pincode,
        selectedStateId: event.SelectedstateId,
      );
      
      if (employeeResponse.statusCode == 200) {
        // Emit success state when the API call is successful
        emit(EmployeePostSuccess("Employee details updated successfully!"));
      } else {
        // Emit failure state with an error message if the response isn't 200
        emit(EmployeePostFailure(
            "Failed to update employee details. Please try again.",
            errorLoading: true));
      }
    } catch (e) {
      // Emit failure state with the error message on exception
      print('Error occurred while posting employee data: $e');
      emit(EmployeePostFailure("Error: ${e.toString()}", errorLoading: true));
    }
  }
}
