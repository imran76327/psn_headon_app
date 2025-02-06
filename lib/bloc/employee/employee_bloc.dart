import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:headon/model/home/employee_model.dart';

import '../../model/home/stateModal.dart';
import '../../services/web_service/web_service_api.dart';

part 'employee_event.dart';
part 'employee_state.dart';


class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeLoading()) {
    on<EmployeeFetch>(employeeData);
  }

  /// Checks for the homeenticated user in the device
  Future<void> employeeData(EmployeeFetch event, emit) async {
    try {
      WebServiceApi api = WebServiceApi();
      // Pass employeeId and companyId to fetchEmployeeDetails
      final EmployeeModal employee = await api.fetchEmployeeDetails(event.employeeId, event.companyId);
      final List<StateModal> stateModal = await api.fetchStateName();
      print(employee);
      emit(EmployeeSuccess(employee,stateModal));
    } catch (e) {
      print('error');
      print(e);
      emit(EmployeeError(e.toString(), errorLoading: true));
    }
  }
}
