import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../local/auth_shared_prefs.dart';

final types = [
  HealthDataType.STEPS,
  HealthDataType.WEIGHT,
  HealthDataType.HEIGHT,
  HealthDataType.BLOOD_GLUCOSE,
  HealthDataType.WORKOUT,
  HealthDataType.HEART_RATE,
  HealthDataType.STEPS,
  HealthDataType.ACTIVE_ENERGY_BURNED
];

// with coresponsing permissions
final permissions = [
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
];

HealthFactory health = HealthFactory();
// class FitSync {
Future<bool> getHealthAuth() async {
  await health.revokePermissions();
  final healthAuthGrant =
      await health.requestAuthorization(types, permissions: permissions);
  AuthSharedPreferences.saveHealthAuthPrefs(healthAuthGrant);
  print('requested: $healthAuthGrant');
  return (healthAuthGrant);
  // await Permission.activityRecognition.request();
  // await Permission.location.request();
}

// }





