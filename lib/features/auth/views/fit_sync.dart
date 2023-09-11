import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/features/auth/services/local/auth_shared_prefs.dart';
import 'package:insides/features/homescreen/homescreen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;

import '../../../presentation/resources/asset_manager.dart';
import '../services/remote/health/fit_sync_service.dart';

class FitSync extends StatefulWidget {
  const FitSync({Key? key}) : super(key: key);

  @override
  State<FitSync> createState() => _FitSyncState();
}

class _FitSyncState extends State<FitSync> {
  late bool authGranted;

  Widget _syncButton() {
    if (Platform.isAndroid) {
      return Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          width: double.infinity,
          height: 45,
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
              await getHealthAuth();
              setState(() {});
            },
            label: Text(
              "Google Fit Sync",
              style: GoogleFonts.openSans(
                  color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: OutlinedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.black,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
              await getHealthAuth();
              setState(() {});
            },
            label: Text(
              "Health Kit Sync",
              style: GoogleFonts.openSans(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey),
            ),
          ),
          child: OutlinedButton(
            onPressed: () async {
              if (authGranted) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }
              setState(() {});
            },
            child: FutureBuilder(
                future: AuthSharedPreferences.getHealthAuthPrefs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the future to complete
                    return CircularProgressIndicator();
                  } else {
                    final authData =
                        snapshot.data; // Store the data in a local variable

                    // Check if authData is not null and is of type bool
                    if (authData != null && authData is bool) {
                      authGranted = authData;
                    }
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: (authGranted)
                            ? LinearGradient(
                                colors: <Color>[
                                  AppColors.primaryColor,
                                  AppColors.primaryColor,
                                ],
                              )
                            : const LinearGradient(
                                colors: <Color>[
                                  Colors.grey,
                                  Colors.grey,
                                ],
                              ),
                      ),
                      margin: EdgeInsets.only(
                          left: 0, right: 0, bottom: 10, top: 5),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 45,
                      child: const Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: false,
              // automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              // pinned: true,
              // expandedHeight: 110,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                expandedTitleScale: 1.3,
                // titlePadding: EdgeInsets.only(left: 15, bottom: 15),
                title: Text(
                  Platform.isAndroid ? "GOOGLE FIT SYNC" : "HEALTH KIT SYNC",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [_syncButton()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
