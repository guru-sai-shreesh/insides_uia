import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user.dart';

class AuthSharedPreferences {
  static Future<void> localSave(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> localGet(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> localDelete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  } //These are shared pref Utilities

  static Future<bool> isOauth2Logged() async {
    if (await localGet('user_data') != null) {
      return true;
    }
    return false;
  }

  static Future<void> saveUserDataInPrefs(UserModel userModel) async {
    final userData = userModel.toJson();
    await localSave('user_data', jsonEncode(userData));
  }

  static Future<UserModel?> getUserDataFromPrefs() async {
    final userDataString = await localGet('user_data');
    if (userDataString != null) {
      final Map<String, dynamic> userDataMap = jsonDecode(userDataString);
      return UserModel.fromJson(userDataMap);
    }
    return null;
  }

  static Future<void> deleteUserFromPrefs() async {
    await localDelete('user_data');
  }

  static Future<void> saveHealthAuthPrefs(bool granted) async {
    await localSave('permission_data', granted.toString());
  }

  static Future<bool> getHealthAuthPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final granted = prefs.getString('permission_data');
    return granted == "true" ? true : false;
  }
}
