class HealthDataModel {
  final String steps;
  final String weight;
  final String height;
  final String bloodPressureSystolic;
  final String bloodPressureDiastolic;
  final String heartRate;
  final String wSteps;

  HealthDataModel(
      {required this.steps,
      required this.weight,
      required this.height,
      required this.bloodPressureSystolic,
      required this.bloodPressureDiastolic,
      required this.heartRate,
      required this.wSteps});

  factory HealthDataModel.fromJson(Map<String, dynamic> json) {
    return HealthDataModel(
      steps: json['steps'],
      weight: json['weight'],
      height: json['height'],
      bloodPressureSystolic: json['bloodPressureSystolic'],
      bloodPressureDiastolic: json['bloodPressureDiastolic'],
      heartRate: json['heartRate'],
      wSteps: json['wSteps'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps,
      'weight': weight,
      'height': height,
      'bloodPressureSystolic': bloodPressureSystolic,
      'bloodPressureDiastolic': bloodPressureDiastolic,
      'heartRate': heartRate,
    };
  }
}
