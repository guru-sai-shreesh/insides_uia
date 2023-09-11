import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/heath_data.dart';

class FitnessSharedPreferences {
  static Future<void> cacheHealthData(HealthDataModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = data.toJson();
    await prefs.setString('health_data', jsonEncode(jsonData));
  }

  static Future<HealthDataModel?> getCachedHealthData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('health_data');
    if (jsonData != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonData);
      return HealthDataModel.fromJson(jsonMap);
    }
    return null;
  }
}
