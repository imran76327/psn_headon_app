import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../utils/constants/string_constants.dart';
import '../../utils/logging/logger.dart';
import '../../utils/typedefs.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String name;
  final String employee_id;
  final int roleId;
  final bool isActive;
  final String company_id;

  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.roleId,
    required this.isActive,
    required this.employee_id,
    required this.company_id,
  });

  @override
  List<Object?> get props => [id, username, name, roleId, isActive,employee_id,company_id];

  Future<void> save() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'user_id', value: id.toString());
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'name', value: name);
    await storage.write(key: 'role_id', value: roleId.toString());
    await storage.write(key: 'is_active', value: isActive.toString());
    await storage.write(key: 'employee_id', value: employee_id.toString());
    await storage.write(key: 'company_id', value: company_id.toString());
  }

  static Future<User> load() async {
    const storage = FlutterSecureStorage();
    bool remember = (await storage.read(key: 'remember')) == 'true';
    if (!remember) {
      throw Exception('User not found');
    }
    bool isTokenExpired(String token) {
      try {
        Json jwt = JwtDecoder.decode(token);
        int exp = jwt['exp'];
        int now = (DateTime.now().add(const Duration(minutes: 2)))
                .millisecondsSinceEpoch ~/
            1000;
        return now > exp;
      } catch (e) {
        TLogger.error("Error in checking token expiration", e);
        return true;
      }
    }

    String? accessToken =
        await storage.read(key: StringConstants.ACCESS_TOKEN_KEY);
    String? refreshToken =
        await storage.read(key: StringConstants.REFRESH_TOKEN_KEY);
    if (refreshToken == null) {
      throw Exception('User not found');
    }
    bool isRefreshTokenExpired = isTokenExpired(refreshToken);
    if (isRefreshTokenExpired) {
      throw Exception('User Sessioned Out');
    }
    int? id = int.tryParse(await storage.read(key: 'user_id') ?? '-');
    String username = await storage.read(key: 'username')?? '';
    String name = await storage.read(key: 'name')?? '';
    int? roleId = int.tryParse(await storage.read(key: 'role_id') ?? '-');
    bool isActive = await storage.read(key: 'is_active') == 'true';
    String employeeId = await storage.read(key: 'employee_id')?? '';
    String? companyId = await storage.read(key: 'company_id')?? '';

    if (id == null || roleId == null) {
      throw Exception('User details not found');
    }

    return User(
      id: id,
      username: username,
      name: name,
      roleId: roleId,
      isActive: isActive,
      employee_id: employeeId,
      company_id: companyId,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['email'],
      name: json['full_name'],
      roleId: json['role_id'],
      isActive: json['is_active'],
      employee_id: json['employee_id']??"",
      company_id:json['company_id']?? "0",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'roleId': roleId,
      'isActive': isActive,
      'employee_id': employee_id,
      'company_id':company_id
    };
  }

  // void navigateToDashboard(BuildContext context) {
  //   switch (roleId) {
  //     case 1:
  //       Navigator.pushReplacementNamed(context, MainPage.routeName);
  //       break;
  //     case 2:
  //       Navigator.pushReplacementNamed(context, '/washer-dash');
  //       break;
  //     case 3:
  //       Navigator.pushReplacementNamed(context, '/admin-dash');
  //       break;
  //     default:
  //       // Somethings wrong
  //       Navigator.pushReplacementNamed(context, SignInPage.routeName);
  //       break;
  //   }
  // }

  static Future<void> clear() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'user_id');
    await storage.delete(key: 'username');
    await storage.delete(key: 'name');
    await storage.delete(key: 'role_id');
    await storage.delete(key: 'is_active');
    await storage.delete(key: 'employee_id');
    await storage.delete(key: 'company_id');
  }
}
