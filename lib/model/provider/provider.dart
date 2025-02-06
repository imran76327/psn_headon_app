import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user/user.dart';

class ProviderModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> setUser(User user) async {
    _user = user;

    // Save user data to shared preferences
    final userJsonString = jsonEncode(user.toJson());

    // Save user data to shared preferences
    final prefs = await SharedPreferences.getInstance();
    // PrefService prefService = PrefService();
    prefs.setString('user', userJsonString);
    // prefService.createCache('user', userJsonString);
    final Map<String, dynamic> userJson = jsonDecode(userJsonString);

    // Create a User instance from the JSON object
    _user = User.fromJson(userJson);
    await prefs.setString('EmployeeId', _user!.id.toString());
    await prefs.setString('InTime', "00:00:00");
    await prefs.setString('isCheckOut', "0");
    await prefs.setString('OutTime', "00:00:00");
    await prefs.setString("marking", "0");
    await prefs.setString("name", _user!.name);

    // prefService.createCache('EmployeeId', _user!.id.toString());
    // prefService.createCache('Latitude', _user!.latitude);
    // prefService.createCache('Longitude', _user!.longitude);
    // prefService.createCache('in_shift_time', _user!.in_shift_time);
    // prefService.createCache('out_shift_time', _user!.out_shift_time);
    // prefService.createCache('InTime', "00:00:00");
    // prefService.createCache('isCheckOut', "0");
    // prefService.createCache('OutTime', "00:00:00");
    // prefService.createCache("marking", "0");
    // prefService.createCache("name", _user!.name);

    notifyListeners();
  }

  Future<void> loadUser() async {
    // Load user data from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final employeeId = prefs.getString('EmployeeId');
    final userJsonString = prefs.getString('user');
    if (userJsonString != null) {
      try {
        // Attempt to parse the JSON string into a Map<String, dynamic>
        final Map<String, dynamic> userJson = jsonDecode(userJsonString);

        // Create a User instance from the JSON object
        _user = User.fromJson(userJson);
        if (_user != null) {
          prefs.setString("EmployeeId", _user!.id.toString());
        }
        notifyListeners();
      } catch (e) {
        // Handle parsing error, such as invalid JSON format
        print('Error parsing user data: $e');
      }
    }

    // var result = await LoginApi.fetchUser(employeeId);
    // if (result != null) {
    //   if (result.id.toString() != "") {
    //     ProviderModel providerModel = ProviderModel();
    //     // ignore: use_build_context_synchronously
    //     providerModel.setUser(result);
    //   }
    //   final userJsonString = prefs.getString('user');
    //   if (userJsonString != null) {
    //     try {
    //       // Attempt to parse the JSON string into a Map<String, dynamic>
    //       final Map<String, dynamic> userJson = jsonDecode(userJsonString);

    //       // Create a User instance from the JSON object
    //       _user = User.fromJson(userJson);
    //       if (_user != null) {
    //         prefs.setString("EmployeeId", _user!.id.toString());
    //       }
    //       notifyListeners();
    //     } catch (e) {
    //       // Handle parsing error, such as invalid JSON format
    //       print('Error parsing user data: $e');
    //     }
    //   }
    // }
  }

  void logout() async {
    _user = null;
    notifyListeners();

    // Clear user data from shared preferences on logout
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  // Method to fetch EmployeeId from SharedPreferences
  Future<String?> getEmployeeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('EmployeeId');
  }

  // Method to fetch Latitude from SharedPreferences
  Future<String?> getLatitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Latitude');
  }

  // Method to fetch Longitude from SharedPreferences
  Future<String?> getLongitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Longitude');
  }

  // Method to fetch in_shift_time from SharedPreferences
  Future<String?> getInShiftTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('in_shift_time');
  }

  // Method to fetch out_shift_time from SharedPreferences
  Future<String?> getOutShiftTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('out_shift_time');
  }

  // Method to fetch InTime from SharedPreferences
  Future<String?> getInTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('InTime');
  }

  // Method to fetch isCheckOut from SharedPreferences
  Future<String?> getIsCheckOut() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('isCheckOut');
  }

  // Method to fetch OutTime from SharedPreferences
  Future<String?> getOutTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('OutTime');
  }

  // Method to fetch marking from SharedPreferences
  Future<String?> getMarking() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('marking');
  }

  // Method to fetch name from SharedPreferences
  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  Future<String?> getCurrentDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('CurrentDate');
  }

  Future<void> setEmployeeId(String employeeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('EmployeeId', employeeId);
  }

  // Method to set Latitude in SharedPreferences
  Future<void> setLatitude(String latitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Latitude', latitude);
  }

  // Method to set Longitude in SharedPreferences
  Future<void> setLongitude(String longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Longitude', longitude);
  }

  // Method to set in_shift_time in SharedPreferences
  Future<void> setInShiftTime(String inShiftTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('in_shift_time', inShiftTime);
  }

  // Method to set out_shift_time in SharedPreferences
  Future<void> setOutShiftTime(String outShiftTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('out_shift_time', outShiftTime);
  }

  // Method to set InTime in SharedPreferences
  Future<void> setInTime(String inTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('InTime', inTime);
  }

  // Method to set isCheckOut in SharedPreferences
  Future<void> setIsCheckOut(String isCheckOut) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('isCheckOut', isCheckOut);
  }

  // Method to set OutTime in SharedPreferences
  Future<void> setOutTime(String outTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('OutTime', outTime);
  }

  // Method to set marking in SharedPreferences
  Future<void> setMarking(String marking) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('marking', marking);
  }

  // Method to set name in SharedPreferences
  Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  Future<void> setCurrentDate(String currentDate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('CurrentDate', currentDate);
  }
}
