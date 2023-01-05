import 'dart:convert';

List<Hospital> hospitalFromJson(String str) =>
    List<Hospital>.from(json.decode(str).map((x) => Hospital.fromJson(x)));

String hospitalToJson(List<Hospital> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hospital {
  Hospital({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.website,
    required this.email,
    required this.coordinates,
    required this.rating,
    required this.tests,
  });

  int id;
  String name;
  String address;
  String phone;
  String website;
  String email;
  dynamic coordinates;
  int rating;
  List<Test> tests;

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        website: json["website"],
        email: json["email"],
        coordinates: json["coordinates"],
        rating: json["rating"],
        tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "website": website,
        "email": email,
        "coordinates": coordinates,
        "rating": rating,
        "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
      };
}

Test testsFromJson(String str) => Test.fromJson(json.decode(str));

String testsToJson(Test data) => json.encode(data.toJson());

class Test {
  Test({
    required this.id,
    required this.name,
    required this.cost,
    required this.description,
    required this.format,
    required this.photoUrl,
  });

  int id;
  String name;
  int cost;
  String description;
  dynamic format;
  String photoUrl;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        name: json["name"],
        cost: json["cost"],
        description: json["description"],
        format: json["format"],
        photoUrl: json["photoURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost": cost,
        "description": description,
        "format": format,
        "photoURL": photoUrl,
      };
}

List<DiseaseTests> diseaseTestsFromJson(String str) => List<DiseaseTests>.from(
    json.decode(str).map((x) => DiseaseTests.fromJson(x)));

String diseaseTestsToJson(List<DiseaseTests> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiseaseTests {
  DiseaseTests({
    required this.id,
    required this.diseaseId,
    required this.testId,
  });

  int id;
  int diseaseId;
  int testId;

  factory DiseaseTests.fromJson(Map<String, dynamic> json) => DiseaseTests(
        id: json["id"],
        diseaseId: json["disease_id"],
        testId: json["test_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "disease_id": diseaseId,
        "test_id": testId,
      };
}

List<DiseaseCategory> diseaseCategoryFromJson(String str) =>
    List<DiseaseCategory>.from(
        json.decode(str).map((x) => DiseaseCategory.fromJson(x)));

String diseaseCategoryToJson(List<DiseaseCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiseaseCategory {
  DiseaseCategory({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.symptoms,
    required this.description,
  });

  int id;
  String name;
  String photoUrl;
  String symptoms;
  String description;

  factory DiseaseCategory.fromJson(Map<String, dynamic> json) =>
      DiseaseCategory(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        symptoms: json["symptoms"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
        "symptoms": symptoms,
        "description": description,
      };
}
