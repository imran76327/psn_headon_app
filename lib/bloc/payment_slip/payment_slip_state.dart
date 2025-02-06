part of 'payment_slip_bloc.dart';

abstract class PaymentSlipState {}

class PaymentSlipInitial extends PaymentSlipState {}

class PaymentSlipLoading extends PaymentSlipState {}

class PaymentSlipLoaded extends PaymentSlipState {
  final PaySlip paymentSlip;

  PaymentSlipLoaded(this.paymentSlip);
}

class PaymentSlipError extends PaymentSlipState {
  final String message;

  PaymentSlipError(this.message);

  get error => null;
}
