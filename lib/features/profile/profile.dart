import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/features/auth/model/user.dart';
import 'package:insides/features/auth/services/local/auth_shared_prefs.dart';
import 'package:insides/features/auth/services/remote/health/fit_sync_service.dart';
import 'package:insides/features/auth/views/auth_screen.dart';
import 'package:insides/features/profile/edit_profile.dart';

import '../auth/services/remote/oauth2/firebase_auth_service.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // late String photoUrl;
  late UserModel user;

  Future<void> fetchUserData() async {
    user = (await AuthSharedPreferences.getUserDataFromPrefs())!;
  }

  final FirebaseAuthService auth = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: false,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              expandedHeight: 70,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                expandedTitleScale: 1.3,
                titlePadding: EdgeInsets.only(left: 15, bottom: 15),
                title: Text(
                  "Profile",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: fetchUserData(),
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 76,
                                          backgroundColor: Colors.black54,
                                          child: CircleAvatar(
                                            radius: 72,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 69,
                                              backgroundColor: Colors.grey,
                                              backgroundImage:
                                                  NetworkImage(user.photoURL),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    user.displayName,
                                    style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    user.email,
                                    style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 40,
                          child: OutlinedButton(
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
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfile()));
                            },
                            child: Text(
                              "Edit Profile",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          leading: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          title: const Text(
                            "Settings",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dense: false,
                        ),
                        ListTile(
                          leading: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.rotate_left_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          title: const Text(
                            "Previous Subscriptions",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dense: false,
                        ),
                        ListTile(
                          leading: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: const Icon(
                                  Icons.badge,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          title: const Text(
                            "My Doctors",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dense: false,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          leading: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: const Icon(
                                  Icons.group,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          title: const Text(
                            "About Us",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dense: false,
                        ),
                        ListTile(
                          onTap: () async {
                            auth.signOutUser();
                            await AuthSharedPreferences.deleteUserFromPrefs();
                            if (Platform.isAndroid) {
                              health.revokePermissions();
                              await AuthSharedPreferences.saveHealthAuthPrefs(
                                  false); //As IOS doesn't revoke permissions
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => AuthScreen())));
                          },
                          leading: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: const Icon(
                                  Icons.logout_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          trailing: Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          title: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dense: false,
                        ),
                      ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
