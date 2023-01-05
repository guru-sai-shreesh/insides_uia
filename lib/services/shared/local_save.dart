import 'package:shared_preferences/shared_preferences.dart';

Future<void> localSave(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> localGet(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<void> localDelete(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<void> saveUser(String name, String email, String upiID, String campus,
    String hostel, String photoUrl) async {
  localSave("username", name);
  localSave("email", email);
  localSave("upi", upiID);
  localSave("campus", campus);
  localSave("hostel", hostel);
  localSave("photoUrl", photoUrl);
}

var userAttrs = ["photoUrl", "email", "username", "upi", "campus", "hostel"];

Future<void> deleteUser() async {
  for (var attr in userAttrs) {
    localDelete(attr);
  }
}

Future<Map<dynamic, dynamic>> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  var userDetails = Map.fromIterable(userAttrs,
      key: (attr) => attr, value: (attr) => prefs.getString(attr));
  return userDetails;
}
