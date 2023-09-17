import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/features/dashboard/dashboard.dart';
import 'package:insides/features/fitness/views/fitness.dart';
import 'package:insides/features/fitness/views/health_insights.dart';
import 'package:insides/features/mindful/mindful.dart';
import 'package:insides/features/prescriptions/prescriptions.dart';
import 'package:insides/features/profile/profile.dart';
import 'package:insides/features/sleep/sleep.dart';
import 'package:insides/model/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      Dashboard(),
      Mindful(),
      Fitness(),
      Prescriptions(),
      Profile()
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColors.primaryColor,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
              }),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: "Wellness",
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_run),
                label: "Fitness",
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.article_rounded),
                label: "Prescriptions",
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Profile",
                backgroundColor: Colors.grey),
          ]),
      body: IndexedStack(
        children: screens,
        index: currentIndex,
      ),
    );
  }
  //   return MaterialApp(
  //     home: Scaffold(
  //         appBar: AppBar(
  //           title: const Text('Health Example'),
  //           actions: <Widget>[
  //             IconButton(
  //               icon: Icon(Icons.file_download),
  //               onPressed: () {
  //                 fetchData();
  //               },
  //             ),
  //             IconButton(
  //               onPressed: () {
  //                 addData();
  //               },
  //               icon: Icon(Icons.add),
  //             ),
  //             IconButton(
  //               onPressed: () {
  //                 fetchStepData();
  //               },
  //               icon: Icon(Icons.nordic_walking),
  //             )
  //           ],
  //         ),
  //         body: Center(
  //           child: _content(),
  //         )),
  //   );
  // }
}
