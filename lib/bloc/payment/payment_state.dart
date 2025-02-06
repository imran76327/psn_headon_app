part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PaymentSlip> paymentRecords;

  const PaymentLoaded({required this.paymentRecords});

  @override
  List<Object> get props => [paymentRecords];
}

final class PaymentError extends PaymentState {
  final bool errorLoading; // Specifies if this error is related to loading
  final String message;

  const PaymentError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message, errorLoading];
}

final class PaymentSuccess extends PaymentState {
  final List<PaymentSlip> paymentRecords; // Add paymentRecords here

  const PaymentSuccess({required this.paymentRecords});

  @override
  List<Object> get props => [paymentRecords]; // Add paymentRecords to props
}
