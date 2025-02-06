// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/user/user.dart';
import '../../model/user/user_with_token.dart';
import '../../services/auth_service/auth_service.dart';
import '../../utils/logging/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading()) {
    on<AuthCheck>(_authCheck);
    on<AuthLogin>(_authLogin);
    on<AuthLogout>(_authLogout);
    on<RegisterDeviceToken>(_registerDeviceToken);
    on<SendOtpEvent>(_sendOtpEvent);
    on<VerifyOtpEvent>(_verifyOtpEvent);
    on<AuthIni>(_authIni);
  }

  /// Checks for the authenticated user in the device
  Future<void> _authCheck(AuthCheck event, emit) async {
    try {
      final user = await User.load();
      emit(AuthSuccess(user));
    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString(), errorLoading: true));
    }
  }

  Future<void> _registerDeviceToken(RegisterDeviceToken event, emit) async {
    try {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      String? token = await _firebaseMessaging.getToken();
      print("token$token");
      const _storage = FlutterSecureStorage();
      // Fetch device token
      print("Firebase Device Token: $token");

      if (token != null) {
        await AuthService.instance.sendTokenToServer(token);
      }
    } catch (e) {
      print("Error fetching device token: $e");
    }
  }

  /// Logs in the user
  Future<void> _authLogin(AuthLogin event, emit) async {
    emit(AuthLoading());
    try {
      final user = await AuthService.instance
          .login(event.email, event.password, event.token);
      const storage = FlutterSecureStorage();
      await storage.write(
          key: 'remember', value: event.rememberMe ? 'true' : 'false');
      await user.saveTokens();
      await user.save();

      emit(AuthSuccess(user));
    } catch (e) {
      TLogger.error(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _authIni(AuthIni event, emit) async {
    // emit(AuthLoading());
    try {
      emit(const AuthInitial());
    } catch (e) {
      TLogger.error(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _sendOtpEvent(SendOtpEvent event, emit) async {
    emit(AuthLoading());
    try {
      final otp = generateRandomOtp();
      // Store OTP securely
      const storage = FlutterSecureStorage();
      await storage.write(key: 'otp', value: otp.toString());
      await AuthService.instance
          .sendOtp(event.phoneNumber, otp.toString(), "Login");
      print(otp);
      emit(OtpSentState(otp: otp));
    } catch (e) {
      TLogger.error(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _verifyOtpEvent(VerifyOtpEvent event, emit) async {
    emit(AuthLoading());
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
      emit(AuthError(e.toString()));
    }
  }

  String generateRandomOtp() {
    final random = Random();
    // Generate a random number between 1000 and 9999
    int otp =
        1000 + random.nextInt(9000); // This ensures the OTP is always 4 digits
    return otp.toString();
  }

  Future<void> _authLogout(AuthLogout event, emit) async {
    await UserWithToken.clear();
    emit(const AuthError("Logout successful"));
  }
}
