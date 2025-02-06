import 'package:dio/dio.dart';

import '../../model/user/user.dart';
import '../../model/user/user_with_token.dart';
import '../service_helper.dart';
import 'auth_service.dart';

class AuthServiceApi implements AuthService {
  final _api = ServiceHelper().dio;

  @override
  Future<UserWithToken> login(
      String email, String password, String? token) async {
    try {
      final response = await _api.post(
        '/Applogin',
        data: {'phone': email, 'password': password, 'device_token': token},
      );

      final user = UserWithToken.fromJson(response.data);
      return user;
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        // The server responded with an error status code
        if (e.response?.statusCode == 400) {
          print('Invalid request: ${e.response?.data}');
          throw Exception('Invalid request: ${e.response?.data}');
        } else {
          print(
              'Server error: ${e.response?.statusCode} ${e.response?.statusMessage}');
          throw Exception(
              'Server error: ${e.response?.statusCode} ${e.response?.statusMessage}');
        }
      } else {
        // There was an error sending the request
        print('Request error: ${e.message}');
        throw Exception('Request error: ${e.message}');
      }
    } catch (e) {
      // Handle any other errors
      print('An unexpected error occurred: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<User> signUp(String email, String password, String name, String phone,
      String? deviceToken) async {
    try {
      final response = await _api.post(
        '/register',
        data: {
          'email': email,
          'password': password,
          'full_name': name,
          'phone': phone,
          'device_token': deviceToken
        },
      );

      final user = User.fromJson(response.data);
      return user;
    } catch (e) {
      if (e is DioException) {
        print('Request failed with status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Unexpected error: $e');
      }
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  sendTokenToServer(String? token) async {
    try {
      final response = await _api.post(
        '/register_device_token',
        data: {
          'device_token': token,
        },
      );
      return response;
    } catch (e) {
      return "";
    }
  }

  @override
  sendOtp(String phone, String otp, String type) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
          // ignore: prefer_interpolation_to_compose_strings
          'https://api.pinnacle.in/index.php/sms/send/PSNMYT/' +
              phone +
              "/Your OTP for  $type is $otp. DO NOT share this OTP with anyone. PSN Supply Chain Solutions Pvt Ltd." +
              "/TXT?apikey=158990-692aa9-66b4a6-95e3cc-46b2af");

      return response;
    } catch (e) {
      return "";
    }
  }
}
