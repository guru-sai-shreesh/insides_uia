import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

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

bool? requested;

HealthFactory health = HealthFactory();
// class FitSync {
Future<void> syncPerm() async {
  requested =
      await health.requestAuthorization(types, permissions: permissions);
  print('requested: $requested');

  await Permission.activityRecognition.request();
  await Permission.location.request();
}

// }





