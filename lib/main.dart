import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:insides/services/utils/firebase_options.dart';

import 'package:insides/app/my_app.dart';

// Future<bool> isPrefLogged() async {
//   final prefs = await SharedPreferences.getInstance();
//   final bool? loggedin = prefs.getBool('loggedin');
//   if (loggedin == null) {
//     return false;
//   } else if (loggedin == false) {
//     return false;
//   } else {
//     return true;
//   }
// }

// Future loginPref() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('loggedin', true);
//   print(true);
// }

// Future logoutPref() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('loggedin', false);
//   print(false);
// }

// void main() async {
//   runApp(const MyApp());
// }

// bool isLogedIn() {
//   bool logged = true;
//   return logged;
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider.value(
//             value: Auth(),
//           ),
//         ],
//         child: Consumer<Auth>(
//             builder: (ctx, auth, _) => MaterialApp(
//                 theme: ThemeData(
//                   primarySwatch: Colors.cyan,
//                   primaryColor: Colors.grey[50],
//                   // scaffoldBackgroundColor: Colors.cyan[100],
//                 ),
//                 home: auth.isAuth ? MyRegister() : AuthScreen()
//                 // home: WebViewGoogle("Google"),
//                 )));

//     // return MaterialApp(
//     //     theme: ThemeData(
//     //       primarySwatch: Colors.cyan,
//     //       primaryColor: Colors.grey[50],
//     //       // scaffoldBackgroundColor: Colors.cyan[100],
//     //     ),
//     //     home: AuthScreen());
//     // home: isLogedIn() ? LoginScreen() : HomeScreen());
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This is the last thing you need to add.
  await Firebase.initializeApp(
    name: 'insides',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
