import 'package:flutter/material.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/features/auth/model/user.dart';
import 'package:insides/features/auth/services/local/auth_shared_prefs.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';

File file = File("your initial file");
List<int> imageBytes = file.readAsBytesSync();
String base64Image = base64Encode(imageBytes);

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String photoUrl;
  late UserModel user;

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController program = TextEditingController();
  TextEditingController upiId = TextEditingController();
  TextEditingController hostel = TextEditingController();
  TextEditingController campus = TextEditingController();

  Future<bool> getData() async {
    user = (await AuthSharedPreferences.getUserDataFromPrefs())!;
    firstname.text = user.displayName;
    email.text = user.email;
    photoUrl = user.photoURL;
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 244, 242, 242),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 20, right: 15, left: 15, bottom: 70),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 75,
                                      backgroundColor:
                                          Color.fromARGB(255, 108, 108, 108),
                                      child: CircleAvatar(
                                        radius: 71,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.cardcolor,
                                          radius: 69,
                                          backgroundImage:
                                              NetworkImage(photoUrl),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                            "https://t4.ftcdn.net/jpg/02/83/72/41/360_F_283724163_kIWm6DfeFN0zhm8Pc0xelROcxxbAiEFI.jpg")),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "USER NAME",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      controller: firstname,
                                      cursorHeight: 18,
                                      cursorColor: Colors.blue,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 2,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Enter User name',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "UPI ID",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      controller: upiId,
                                      cursorHeight: 18,
                                      cursorColor: Colors.blue,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 2,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Enter Default UPI id',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "EMAIL",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: email.text,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "ROLL NUMBER",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          hintStyle: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey,
                                          ),
                                          hintText: rollno.text,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "PROGRAM",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: program.text,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "CAMPUS",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      controller: campus,
                                      cursorHeight: 18,
                                      cursorColor: Colors.blue,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 2,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Campus Name',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "HOSTEL",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      controller: hostel,
                                      cursorHeight: 18,
                                      cursorColor: Colors.blue,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 2,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Hostel Name',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ]),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child:
            // ),
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey),
            ),
          ),
          child: OutlinedButton(
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => MyRegister2()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: <Color>[
                    AppColors.cardcolor,
                    AppColors.cardcolor,
                    AppColors.cardcolor,
                  ],
                ),
              ),
              margin: EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 5),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child: Center(
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
