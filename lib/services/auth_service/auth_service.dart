import '../../model/user/user.dart';
import '../../model/user/user_with_token.dart';
import 'auth_service_api.dart';

abstract class AuthService {
  static AuthService instance = AuthServiceApi();

  Future<UserWithToken> login(String email, String password, String? token);
  sendOtp(String phone, String sendOtp, String type);

  Future<User> signUp(String email, String password, String name, String phone,
      String? deviceToken);
  sendTokenToServer(String? token);
}
