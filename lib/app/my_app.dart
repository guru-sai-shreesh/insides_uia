import 'package:flutter/material.dart';

import 'package:insides/presentation/resources/string_manager.dart';
import 'package:insides/presentation/resources/theme_manager.dart';
import 'package:insides/screens/auth_screens/auth_page.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); //private named constructor

  static final MyApp instance = MyApp._internal(); //singleton
  factory MyApp() => instance; //class instance factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringManager.appTitle,
      theme: AppThemeData.getTheme(),
      home:
          // MyHomePage(title: 'AWS Cognito Google Facebook signin'),
          // snapshot.data
          //     ? HomeScreen():
          const AuthPage(),
    );
  }
}
