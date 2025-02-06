import 'package:bloc/bloc.dart';

import '../../model/home/payment_slip_model.dart';
import '../../services/web_service/web_service_api.dart';

part 'payment_slip_event.dart';
part 'payment_slip_state.dart';

class PaymentSlipBloc extends Bloc<PaymentSlipEvent, PaymentSlipState> {
  PaymentSlipBloc() : super(PaymentSlipInitial()) {
    on<FetchPaymentSlip>(_onFetchPaymentSlip);
  }

  /// Fetches payment slip data using the provided employeeId and slotId
  Future<void> _onFetchPaymentSlip(
      FetchPaymentSlip event, Emitter<PaymentSlipState> emit) async {
    try {
      WebServiceApi api = WebServiceApi();
      emit(PaymentSlipLoading());

      // Fetch payment slip details from the API
      final PaySlip paymentSlip = await api.fetchPaymentSlipDetails(
        event.employeeId,
        event.slotId,
      );

      emit(PaymentSlipLoaded(paymentSlip));
    } catch (e) {
      print('Error fetching payment slip: $e');
      emit(PaymentSlipError(e.toString()));
    }
  }
}


