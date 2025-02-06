part of 'payment_slip_bloc.dart';

abstract class PaymentSlipEvent {}

class FetchPaymentSlip extends PaymentSlipEvent {
  final String employeeId;
  final int slotId;

  FetchPaymentSlip(this.employeeId, this.slotId);
}
