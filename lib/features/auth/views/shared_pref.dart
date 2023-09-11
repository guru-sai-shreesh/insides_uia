import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String keyUsername = 'username';
  static const String keyEmail = 'email';
  static const String keyProfilePhoto = 'profilePhoto';

  static Future<void> saveUserInfo({
    required String username,
    required String email,
    required String profilePhotoUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUsername, username);
    prefs.setString(keyEmail, email);
    prefs.setString(keyProfilePhoto, profilePhotoUrl);
  }

  static Future<Map<String, String>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(keyUsername) ?? '';
    final email = prefs.getString(keyEmail) ?? '';
    final profilePhotoUrl = prefs.getString(keyProfilePhoto) ?? '';

    return {
      keyUsername: username,
      keyEmail: email,
      keyProfilePhoto: profilePhotoUrl,
    };
  }

  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(keyUsername);
    prefs.remove(keyEmail);
    prefs.remove(keyProfilePhoto);
  }

  Future<void> displayUserInfo() async {
    final userInfo = await SharedPreferencesManager.getUserInfo();
    final username = userInfo[SharedPreferencesManager.keyUsername];
    final email = userInfo[SharedPreferencesManager.keyEmail];
    final profilePhotoUrl = userInfo[SharedPreferencesManager.keyProfilePhoto];

    print('Username: $username');
    print('Email: $email');
    print('Profile Photo URL: $profilePhotoUrl');
  }
}
