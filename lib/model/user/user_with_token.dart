import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../utils/constants/string_constants.dart';
import 'user.dart';

class UserWithToken extends User {
  final String accessToken;
  final String refreshToken;

  const UserWithToken({
    required this.accessToken,
    required this.refreshToken,
    required super.id,
    required super.username,
    required super.name,
    required super.roleId,
    required super.isActive,
    required super.employee_id,
    required super.company_id,
  });

  factory UserWithToken.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json["data"]);
    String employeeId = json["employee_id"];
    String companyId = json["company_id"].toString();
    return UserWithToken(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      id: user.id,
      username: user.username,
      name: user.name,
      roleId: user.roleId,
      isActive: user.isActive,
      employee_id: employeeId,
      company_id: companyId,
    );
  }

  Future<void> saveTokens() async {
    const storage = FlutterSecureStorage();
    await storage.write(
        key: StringConstants.ACCESS_TOKEN_KEY, value: accessToken);
    await storage.write(
        key: StringConstants.REFRESH_TOKEN_KEY, value: refreshToken);
  }

  static Future<void> clear() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: StringConstants.ACCESS_TOKEN_KEY);
    await storage.delete(key: StringConstants.REFRESH_TOKEN_KEY);
    await User.clear();
  }
}
