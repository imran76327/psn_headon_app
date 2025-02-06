part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final bool errorLoading; // Specifies if this error is related to loading
  final String message;

  const AuthError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message];
}

class OtpSentState extends AuthState {
  final String otp;

  const OtpSentState({required this.otp});
}

class AuthInitial extends AuthState {
  final bool isSignupButtonEnabled;
  const AuthInitial({this.isSignupButtonEnabled = false});
}

class OtpVerifiedState extends AuthState {
  final bool isVerified;

  const OtpVerifiedState({required this.isVerified});
}

final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}
