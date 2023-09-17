import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../auth/services/remote/health/fit_sync_service.dart';

class FetchHealthData {
  Future<int?> fetchNoStep() async {
    int? steps;
    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');
    } else {
      print("Authorization not granted - error in authorization");
      steps = null;
    }
    return steps;
  }

  Future<int?> fetchWNoStep() async {
    int? steps;
    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.weekday);

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');
    } else {
      print("Authorization not granted - error in authorization");
      steps = null;
    }
    return steps;
  }

  late List<HealthDataPoint> _healthDataList = [];

  Future<HealthDataPoint?> bloodPreasureDiastolic() async {
    final types = [
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 365));
    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
      print(healthData.last);
      return healthData.last;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
  }

  Future<HealthDataPoint?> bloodPreasureSystolic() async {
    final types = [
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 365));
    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
      print(healthData.last);
      return healthData.last;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
  }

  Future<HealthDataPoint?> fetchWeight() async {
    final types = [
      HealthDataType.WEIGHT,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 365));
    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
      print(healthData.last);
      return healthData.last;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
  }

  Future<HealthDataPoint?> fetchHeight() async {
    final types = [
      HealthDataType.HEIGHT,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 365));
    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
      return healthData.last;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
  }

  Future<HealthDataPoint?> fetchHR() async {
    final types = [
      HealthDataType.HEART_RATE,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 365));
    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
      return healthData.first;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
  }

  Future<List<HealthDataPoint>?> fetchWStepData() async {
    final types = [
      HealthDataType.HEIGHT,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 5));

    // if (requested) {
    try {
      await health.requestAuthorization(types);
      // fetch health data
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
      // save all the new data points (only the first 100)
      _healthDataList.addAll(
          (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }

    // filter out duplicates
    _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

    // print the results
    _healthDataList.forEach((x) => print(x));
    // } else {
    //   print("Authorization not granted");
    // }
    return _healthDataList;
  }

  Future<List<HealthDataPoint>> fetchWeeklyHeartRateData() async {
    final today = DateTime.now();
    final lastWeek = today.subtract(Duration(days: 7));
    final lastMonth = today.subtract(Duration(days: 30));

    try {
      await health.requestAuthorization([HealthDataType.HEART_RATE]);
      final heartRateData = await health
          .getHealthDataFromTypes(lastWeek, today, [HealthDataType.HEART_RATE]);
      return heartRateData;
    } catch (e) {
      print('Error fetching heart rate data: $e');
      return [];
    }
  }

  Future<List<HealthDataPoint>> fetchMonthlyHeartRateData() async {
    final today = DateTime.now();
    final lastWeek = today.subtract(Duration(days: 7));
    final lastMonth = today.subtract(Duration(days: 30));

    try {
      await health.requestAuthorization([HealthDataType.STEPS]);
      final heartRateData = await health
          .getHealthDataFromTypes(lastMonth, today, [HealthDataType.STEPS]);
      return heartRateData;
    } catch (e) {
      print('Error fetching heart rate data: $e');
      return [];
    }
  }

  Future<List<HealthDataPoint>> fetchWeeklyStepsData() async {
    final today = DateTime.now();
    final lastWeek = today.subtract(Duration(days: 7));
    final lastMonth = today.subtract(Duration(days: 30));

    try {
      await health.requestAuthorization([HealthDataType.STEPS]);
      final heartRateData = await health
          .getHealthDataFromTypes(lastWeek, today, [HealthDataType.STEPS]);
      return heartRateData;
    } catch (e) {
      print('Error fetching steps data: $e');
      return [];
    }
  }

  Future<List<HealthDataPoint>> fetchMonthlyStepsData() async {
    final today = DateTime.now();
    final lastWeek = today.subtract(Duration(days: 7));
    final lastMonth = today.subtract(Duration(days: 30));

    try {
      await health.requestAuthorization([HealthDataType.STEPS]);
      final heartRateData = await health
          .getHealthDataFromTypes(lastMonth, today, [HealthDataType.STEPS]);
      return heartRateData;
    } catch (e) {
      print('Error fetching steps data: $e');
      return [];
    }
  }

  Future<List<HealthDataPoint?>> fetchWeeklyBPSystolic() async {
    final types = [
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final today = DateTime.now();
    final lastWeek = today.subtract(Duration(days: 7));
    final lastMonth = today.subtract(Duration(days: 30));

    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(lastWeek, today, types);
      return healthData;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
      return [];
    }
  }

  Future<List<HealthDataPoint?>> fetchMonthlyBPSystolic() async {
    final types = [
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final today = DateTime.now();
    final lastWeek = today.subtract(Duration(days: 7));
    final lastMonth = today.subtract(Duration(days: 30));

    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(lastMonth, today, types);
      return healthData;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
      return [];
    }
  }

  Future<List<HealthDataPoint?>> fetchWeeklyBPDiastolic() async {
    final types = [
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final today = DateTime.now();
    final lastWeek = today.subtract(Duration(days: 7));
    final lastMonth = today.subtract(Duration(days: 30));

    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(lastWeek, today, types);
      return healthData;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
      return [];
    }
  }

  Future<List<HealthDataPoint?>> fetchMonthlyBPDiastolic() async {
    final types = [
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
    ];

    final today = DateTime.now();
    final lastWeek = today.subtract(Duration(days: 7));
    final lastMonth = today.subtract(Duration(days: 30));

    try {
      await health.requestAuthorization(types);
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(lastMonth, today, types);
      return healthData;
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
      return [];
    }
  }
}
