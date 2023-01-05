import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/main.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';
import 'package:insides/screens/auth_screens/auth_page.dart';
import 'package:insides/screens/profile/edit_profile.dart';
import 'package:insides/services/shared/local_save.dart';
import 'package:insides/services/utils/authentication.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String username;
  late String email;
  late String photoUrl;

  Future<bool> getData() async {
    username =
        await FirebaseAuth.instance.currentUser?.displayName ?? "shreesh";
    email = await localGet("email") ?? "guru.sai.shreesh@gmail.com";
    photoUrl = await localGet("photoUrl") ?? "none";
    return true;
  }

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
                      color: ColourManager.black,
                      fontSize: FontSizeManager.f_20,
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
                            future: getData(),
                            builder: (context, snapshot) {
                              return Column(
                                children: [
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
                                              backgroundColor:
                                                  AppColors.cardcolor,
                                              backgroundImage:
                                                  NetworkImage(photoUrl),
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
                                    username,
                                    style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    email,
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
                          height: 5,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfile()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  AppColors.cardcolor,
                                  AppColors.cardcolor,
                                  AppColors.cardcolor,
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(
                                left: 0, right: 0, bottom: 10, top: 5),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 35,
                            child: Center(
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
                                backgroundColor: AppColors.cardcolor,
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
                                backgroundColor: AppColors.cardcolor,
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
                                backgroundColor: AppColors.cardcolor,
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
                                backgroundColor: AppColors.cardcolor,
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
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => AuthPage())));
                          },
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
                                backgroundColor: AppColors.cardcolor,
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
