import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../services/web_service/web_service_api.dart';

part 'bank_state.dart';
part 'bank_event.dart';

class BankPostBloc extends Bloc<BankPostEvent, BankPostState> {
  BankPostBloc() : super(BankPostInitial()) {
    on<BankPost>(bankData);
  }

  /// Method that processes the employee data and posts it via the API
  Future<void> bankData(BankPost event, emit) async {
    try {
      WebServiceApi api = WebServiceApi();
      // Pass employeeId, companyId, and other details to postEmployeeDetails
      final Response employeeResponse = await api.postBankDetails(
        employeeId: event.employeeId,
        companyId: event.companyId,
        accountHolderName: event.accountHolderName,
        accountNo: event.accountNo,
        bankName: event.bankName,
        branchName: event.branchName,
        ifsc: event.ifsc,
        phone: event.phone,
      );
      
      if (employeeResponse.statusCode == 200) {
        // Emit success state when the API call is successful
        emit(BankPostSuccess("Employee details updated successfully!"));
      } else {
        // Emit failure state with an error message if the response isn't 200
        emit(BankPostFailure(
            "Failed to update employee details. Please try again.",
            errorLoading: true));
      }
    } catch (e) {
      // Emit failure state with the error message on exception
      print('Error occurred while posting employee data: $e');
      emit(BankPostFailure("Error: ${e.toString()}", errorLoading: true));
    }
  }
}
