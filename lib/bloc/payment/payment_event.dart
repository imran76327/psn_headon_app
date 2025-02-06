part of 'payment_bloc.dart';


sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}
class PaymentFetch extends PaymentEvent {
  final String employeeId;

  const PaymentFetch(this.employeeId);
}