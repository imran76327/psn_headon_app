part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class FieldsChangedEvent extends SignUpEvent {
  final String phoneNumber;
  final String username;

  const FieldsChangedEvent({required this.phoneNumber, required this.username});
}

class SendOtpEvent extends SignUpEvent {
  final String phoneNumber;

  const SendOtpEvent({required this.phoneNumber});
}

class VerifyOtpEvent extends SignUpEvent {
  final String enteredOtp;

  const VerifyOtpEvent({required this.enteredOtp});
}

class SignUpIni extends SignUpEvent {
  const SignUpIni();
}

final class SignUpSubmit extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String? device_token;

  const SignUpSubmit(
      this.email, this.password, this.name, this.phone, this.device_token);

  @override
  List<Object> get props => [email, password, name, phone, device_token!];
}
