part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignUpState {
  final bool isSignupButtonEnabled;
  const SignupInitial({this.isSignupButtonEnabled = false});
}

class OtpSentState extends SignUpState {
  final String otp;

  const OtpSentState({required this.otp});
}

class OtpVerifiedState extends SignUpState {
  final bool isVerified;

  const OtpVerifiedState({required this.isVerified});
}

final class SignUpLoading extends SignUpState {}

final class SignUpError extends SignUpState {
  final String message;

  const SignUpError(this.message);

  @override
  List<Object> get props => [message];
}

final class SignUpSuccess extends SignUpState {
  final User user;

  const SignUpSuccess(this.user);

  @override
  List<Object> get props => [user];
}
