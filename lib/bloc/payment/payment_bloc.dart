import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:headon/model/home/payment_modal.dart';

import '../../services/web_service/web_service_api.dart';

part 'payment_event.dart';
part 'payment_state.dart';


class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentLoading()) {
    on<PaymentFetch>(_fetchPaymentData);
  }

  /// Fetches payment data and handles different states
  Future<void> _fetchPaymentData(PaymentFetch event, emit) async {
    try {
      WebServiceApi api = WebServiceApi();

      // Ensure employeeId is available from the event
      final List<PaymentSlip> model = await api.fetchPaymentDetails(event.employeeId);

      // Emit the success state with fetched data and employeeId
      emit(PaymentSuccess(paymentRecords: model));
    } catch (e) {
      // Emit error state with the error message
      emit(PaymentError(e.toString(), errorLoading: true));
    }
  }
}


