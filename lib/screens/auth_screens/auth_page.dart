import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/presentation/auth_view/auth_viewmodel.dart';
import 'package:insides/presentation/widgets.dart';

import 'package:insides/screens/auth_screens/fit_sync.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:insides/presentation/resources/asset_manager.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/string_manager.dart';
import 'package:insides/presentation/resources/style_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';
import 'package:insides/presentation/resources/value_manager.dart';
import 'package:insides/screens/auth_screens/register_screen.dart';
import 'package:insides/services/remote_service.dart';
import 'package:insides/services/shared/local_save.dart';
import 'package:insides/services/utils/authentication.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _counter = 0;
  late String idendity_provider;

  final AuthViewModel _authViewModel = AuthViewModel();

  void _bindToView() {
    _authViewModel.start();
  }

  @override
  void initState() {
    _bindToView();
    super.initState();
  }

  @override
  void dispose() {
    _authViewModel.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: ElevationManager.e_0,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: PaddingManager.p_60,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: PaddingManager.p_25,
              right: PaddingManager.p_25,
            ),
            child: Wrap(
              runSpacing: FontSizeManager.f_20,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            RadiusManager.r_10,
                          ),
                        ),
                      ),
                    ),
                    icon: SvgPicture.asset(
                      ImageAssets.google,
                    ),
                    onPressed: () async {
                      await Authentication.signOut(context: context);
                      final GoogleSignInAccount? googleSignInAccount =
                          await Authentication.signInWithGoogle(
                              context: context);
                      FirebaseAuth auth = FirebaseAuth.instance;
                      String? authToken = await auth.currentUser?.getIdToken();
                      print(auth.currentUser?.getIdToken());

                      String userEmail =
                          googleSignInAccount?.email ?? "No email";
                      if (authToken == null || !mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('auth problem')),
                        );
                        return;
                      }

                      if (googleSignInAccount != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyRegister()));
                        // Response res =
                        //     await RemoteService().getUser(authToken, userEmail);
                        // print(res.body);
                        // var user = json.decode(res.body);
                        // bool userExists = user["userExists"];

                        // if (!userExists) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: ((context) => SignUpScreen())));
                        // } else {
                        //   user = user["user"];
                        //   saveUser(
                        //       user["firstName"] + ' ' + user["lastName"],
                        //       userEmail,
                        //       user["upiId"],
                        //       user["campus"],
                        //       user["hostel"],
                        //       user["profilePicture"]);
                        //   Navigator.pushAndRemoveUntil(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: ((context) => FitSync())),
                        //       (route) => false);
                        // }
                      }
                    },
                    label: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: PaddingManager.p_5,
                      ),
                      child: Text(
                        StringManager.googleSignIn,
                        style: getSemiBoldStyle(
                          colour: ColourManager.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //blue container
              Container(
                margin: const EdgeInsets.only(
                  left: MarginManager.m_15,
                  right: MarginManager.m_15,
                ),
                padding: const EdgeInsets.only(
                  left: PaddingManager.p_25,
                  right: PaddingManager.p_10,
                  top: PaddingManager.p_10,
                  bottom: PaddingManager.p_10,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 55, 143, 112),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      RadiusManager.r_20,
                    ),
                  ),
                ),
                width: size.width,
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //heading
                    Text(
                      StringManager.insides,
                      style: GoogleFonts.openSans(
                          color: ColourManager.white,
                          fontSize: FontSizeManager.f_25,
                          fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(
                      height: AppSizeManager.a_5,
                    ),

                    Text(
                      StringManager.healthTracking,
                      style: GoogleFonts.openSans(
                          color: ColourManager.white,
                          fontSize: FontSizeManager.f_20,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizeManager.a_10,
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(
                  right: MarginManager.m_15,
                ),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: StringManager.developedBy,
                      style: getMediumBoldStyle(
                        fontSize: FontSizeManager.f_12,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\n${StringManager.team}',
                          style: getSemiBoldStyle(
                            colour: ColourManager.black_54,
                            fontSize: FontSizeManager.f_12,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Image(image: AssetImage(ImageAssets.vector)),
            ],
          ),
        ));
  }
}
