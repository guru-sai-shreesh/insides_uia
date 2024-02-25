import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insides/presentation/resources/asset_manager.dart';
import 'package:insides/features/auth/services/remote/oauth2/google_auth_service.dart';
import '../services/remote/oauth2/apple_auth_service.dart';
import '../services/remote/oauth2/facebook_auth_service.dart';
import 'register_screen.dart';
import 'dart:io';

class AuthScreen extends StatefulWidget {
  const AuthScreen({key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  void _handleSignInWithGoogle(BuildContext context) async {
    final user = await _googleAuthService.signInWithGoogle(context);
    if (user != null) {
      // User signed in successfully, handle the logged-in user
      // For example, you can navigate to a new screen or perform other actions.
      // You can also store the user data in shared preferences or state.
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyRegister()));
    }
  }

  final AppleAuthService _appleAuthService =
      AppleAuthService(); // Instantiate AppleAuthService

  void _handleSignInWithApple(BuildContext context) async {
    final user = await _appleAuthService.signInWithApple(context);

    if (user != null) {
      // User signed in successfully, handle the logged-in user
      // You can navigate to a new screen or perform other actions.
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyRegister()));
    }
  }

  final FacebookAuthService _facebookAuthService =
      FacebookAuthService(); // Instantiate FacebookAuthService

  void _handleSignInWithFacebook(BuildContext context) async {
    print("0");
    final user = await _facebookAuthService.signInWithFacebook(context);

    if (user != null) {
      // User signed in successfully, handle the logged-in user
      // You can navigate to a new screen or perform other actions.
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyRegister()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 60,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Wrap(
              runSpacing: 10,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                        ImageAssets.google,
                      ),
                    ),
                    onPressed: () async {
                      _handleSignInWithGoogle(context);
                    },
                    label: Text(
                      "Continue with Google",
                      style: GoogleFonts.openSans(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 24, 119, 242),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                        ImageAssets.facebook,
                      ),
                    ),
                    onPressed: () async {
                      _handleSignInWithFacebook(context);
                    },
                    label: Text(
                      "Continue with Facebook",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Platform.isIOS
                    ? SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.black,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SvgPicture.asset(
                              ImageAssets.apple,
                            ),
                          ),
                          onPressed: () async {
                            _handleSignInWithApple(context);
                          },
                          label: Text(
                            "Continue with Apple",
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                ImageAssets.logo,
                width: size.width * 0.6,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(
                    top: 25,
                    right: 25,
                  ),
                  child: Container()
                  // RichText(
                  //   textAlign: TextAlign.start,
                  //   text: TextSpan(
                  //       text: "Founded By",
                  //       style: GoogleFonts.open5Sans(
                  //         color: Colors.black54,
                  //         fontSize: 12,
                  //       ),
                  //       children: <TextSpan>[
                  //         TextSpan(
                  //           text: '\nGuru sai shreesh',
                  //           style: GoogleFonts.openSans(
                  //             color: Colors.black54,
                  //             fontSize: 12,
                  //             // decoration: TextDecoration.underline,
                  //           ),
                  //         ),
                  //       ]),
                  // ),
                  ),
            ],
          ),
        ));
  }
}
