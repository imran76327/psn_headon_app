part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthCheck extends AuthEvent {}

final class RegisterDeviceToken extends AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  const SendOtpEvent({required this.phoneNumber});
}

class VerifyOtpEvent extends AuthEvent {
  final String enteredOtp;

  const VerifyOtpEvent({required this.enteredOtp});
}

class AuthIni extends AuthEvent {
  const AuthIni();
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  final String? token;
  final bool rememberMe;

  const AuthLogin(this.email, this.password, this.rememberMe, this.token);

  @override
  List<Object> get props => [email, password, token!];
}

final class AuthLogout extends AuthEvent {}
