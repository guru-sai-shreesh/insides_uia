import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'none';

class RemoteService {
  static var client = http.Client();

  Future<http.Response> createUser(String authToken, String name, String upiID,
      String campus, String hostel) async {
    return client.post(
      Uri.parse('$baseUrl/api/v1/user/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'hostel': hostel,
        'upiId': upiID,
        'campus': campus,
      }),
    );
  }

  Future<http.Response> getUser(String authToken, String __email) async {
    return client.get(
      Uri.parse('$baseUrl/api/v1/auth/authCheck'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
    );
  }
}
