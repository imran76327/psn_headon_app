import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/user/user.dart';
import '../../services/auth_service/auth_service.dart';
import '../../utils/logging/logger.dart';
import 'dart:math';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignupInitial()) {
    on<SignUpSubmit>(_signUpSubmit);
    on<FieldsChangedEvent>(_fieldEventChanged);
    on<SendOtpEvent>(_sendOtpEvent);
    on<VerifyOtpEvent>(_verifyOtpEvent);
    on<SignUpIni>(_signUpIni);
  }
  Future<void> _fieldEventChanged(FieldsChangedEvent event, emit) async {
    emit(SignUpLoading());
    try {
      bool isSignupButtonEnabled =
          event.phoneNumber.isNotEmpty && event.username.isNotEmpty;
      emit(SignupInitial(isSignupButtonEnabled: isSignupButtonEnabled));
    } catch (e) {
      TLogger.error(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> _signUpIni(SignUpIni event, emit) async {
    emit(SignUpLoading());
    try {
      emit(const SignupInitial());
    } catch (e) {
      TLogger.error(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> _sendOtpEvent(SendOtpEvent event, emit) async {
    emit(SignUpLoading());
    try {
      final otp = generateRandomOtp();
      // Store OTP securely
      const storage = FlutterSecureStorage();
      await storage.write(key: 'otp', value: otp.toString());
      print(otp);
      await AuthService.instance
          .sendOtp(event.phoneNumber, otp.toString(), "Sign Up");
      emit(OtpSentState(otp: otp));
    } catch (e) {
      TLogger.error(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> _verifyOtpEvent(VerifyOtpEvent event, emit) async {
    emit(SignUpLoading());
    try {
      // Verify the entered OTP
      const storage = FlutterSecureStorage();
      String? storedOtp = await storage.read(key: 'otp');
      bool isVerified = storedOtp != null && storedOtp == event.enteredOtp;
      emit(OtpVerifiedState(isVerified: isVerified));
      if (!isVerified) {
        emit(const OtpSentState(otp: "1111"));
      }
    } catch (e) {
      TLogger.error(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  String generateRandomOtp() {
    final random = Random();
    // Generate a random number between 1000 and 9999
    int otp =
        1000 + random.nextInt(9000); // This ensures the OTP is always 4 digits
    return otp.toString();
  }

  Future<void> _signUpSubmit(SignUpSubmit event, emit) async {
    emit(SignUpLoading());
    try {
      final user = await AuthService.instance.signUp(event.email,
          event.password, event.name, event.phone, event.device_token);
      emit(SignUpSuccess(user));
    } catch (e) {
      TLogger.error(e.toString());
      emit(SignUpError(e.toString()));
    }
  }
}
