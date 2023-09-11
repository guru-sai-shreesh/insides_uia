import 'package:flutter/material.dart';

import 'package:insides/presentation/resources/string_manager.dart';
import 'package:insides/presentation/resources/theme_manager.dart';
import 'package:insides/features/auth/services/local/auth_shared_prefs.dart';
import 'package:insides/features/auth/views/fit_sync.dart';
import 'package:insides/features/homescreen/homescreen.dart';

import '../features/auth/views/auth_screen.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); //private named constructor

  static final MyApp instance = MyApp._internal(); //singleton
  factory MyApp() => instance; //class instance factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Map<String, dynamic>> savePointFetch() async {
    // Fetch data from multiple functions and combine the results
    final isOauth2Logged = await AuthSharedPreferences.isOauth2Logged();
    final getHealthAuthPrefs = await AuthSharedPreferences.getHealthAuthPrefs();

    // Create a Map to store the results
    final data = {
      'oauth': isOauth2Logged,
      'health': getHealthAuthPrefs,
    };

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringManager.appTitle,
      theme: AppThemeData.getTheme(),
      home: FutureBuilder(
          future: savePointFetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for the future to complete
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle the case where an error occurred
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final data = snapshot.data as Map<String, dynamic>;
              final isOauth2Logged = data['oauth'];
              final isFitSync = data['health'];
              if (isOauth2Logged) {
                if (isFitSync) {
                  return HomeScreen();
                } else {
                  return FitSync();
                }
              } else {
                return AuthScreen();
              }
            } else {
              // Handle the case where data is null
              return Text('No data available.');
            }
          }),
    );
  }
}
