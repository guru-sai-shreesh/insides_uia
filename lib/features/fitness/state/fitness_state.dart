import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/health_data.dart';

final healthDataProvider = StateProvider<HealthDataModel>((ref) {
  // Initialize with default values or "--"
  return HealthDataModel(
    height: "--",
    weight: "--",
    heartRate: "--",
    steps: "--",
    bloodPressureSystolic: "--",
    bloodPressureDiastolic: "--",
    wSteps: "--",
    timeStamp: DateTime.now(),
  );
});
