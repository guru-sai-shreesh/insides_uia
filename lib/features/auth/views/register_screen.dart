import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/features/auth/components/custom_textfield.dart';
import 'package:insides/features/auth/services/local/auth_shared_prefs.dart';
import 'package:insides/features/auth/services/remote/health/fit_sync_service.dart';
import 'package:insides/features/auth/state/auth_state_providers.dart';
import 'package:insides/features/dashboard/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../homescreen/homescreen.dart';
import '../components/modal_textfield.dart';
import 'fit_sync.dart';
import 'dart:io' show Platform;

class MyRegister extends ConsumerStatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MyRegisterState();
}

class _MyRegisterState extends ConsumerState<MyRegister> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController feet = TextEditingController();
  TextEditingController inches = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  File? _selectedFile;

  Future<void> _pickProfilePhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = File(result.files.first.path!);
      });
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
              if (Platform.isIOS) {
                bool isHealthDone =
                    await AuthSharedPreferences.getHealthAuthPrefs();
                if (isHealthDone) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => FitSync()));
                }
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FitSync()));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: <Color>[
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                  ],
                ),
              ),
              margin:
                  const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 5),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
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
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: false,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              pinned: true,
              expandedHeight: 120,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final appBarHeight = constraints.maxHeight;
                  // Calculate padding based on the appBarHeight
                  const minPadding = EdgeInsets.only(left: 0, bottom: 15);
                  const maxPadding = EdgeInsets.only(left: 50, bottom: 15);
                  final padding = EdgeInsets.lerp(minPadding, maxPadding,
                      (120 - kToolbarHeight) / (appBarHeight - kToolbarHeight));

                  return FlexibleSpaceBar(
                    titlePadding: padding,
                    centerTitle: false,
                    expandedTitleScale: 1.4,
                    title: Text(
                      "COMPLETE PROFILE",
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 20, right: 15, left: 15, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.black54,
                                  child: CircleAvatar(
                                    radius: 71,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 69,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: _selectedFile != null
                                          ? FileImage(_selectedFile!)
                                              as ImageProvider
                                          : const NetworkImage(
                                              'https://yt3.ggpht.com/ytc/AKedOLRTjSE3cSLWjjTu06H1vmZ3bpTG8SrNONwsfrVh8Q=s900-c-k-c0x00ffffff-no-rj'),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  bottom: 5,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(color: Colors.white),
                                        ),
                                        backgroundColor: Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () async {
                                        _pickProfilePhoto();
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/camera_icon.svg"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                                title: "First Name",
                                controller: firstname,
                                color: AppColors.primaryColor,
                                stateProvider: enteredFirstNameProvider),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                                title: "Last Name",
                                controller: lastname,
                                color: AppColors.primaryColor,
                                stateProvider: enteredLastNameProvider),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, bottom: 5),
                                  child: Text(
                                    "DATE OF BIRTH",
                                    style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 47,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: TextField(
                                    controller: dateInput,
                                    cursorHeight: 18,
                                    cursorColor: AppColors.primaryColor,
                                    readOnly: true,
                                    style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        helpText: "Date Of Birth",
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                primary: Color(0xFF0D47A1),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          dateInput.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                      hintText: 'Choose a date',
                                      suffixIcon: const Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: Colors.black,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
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
                            ModalTextField(
                              title: 'Gender',
                              options: const ['Male', 'Female'],
                              controller: gender,
                              color: AppColors.primaryColor,
                              stateProvider: enteredGenderProvider,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                                title: "Email",
                                controller: email,
                                color: AppColors.primaryColor,
                                stateProvider: enteredEmailProvider),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                                title: "Phone",
                                controller: phone,
                                color: AppColors.primaryColor,
                                stateProvider: enteredPhoneProvider),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                                title: "Address",
                                controller: address,
                                color: AppColors.primaryColor,
                                stateProvider: enteredAddressProvider),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 5),
                                  child: Text(
                                    "HEIGHT",
                                    style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 47,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: TextField(
                                          controller: height,
                                          cursorHeight: 18,
                                          cursorColor: AppColors.primaryColor,
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
                                            hintText: 'Feet',
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
                                      SizedBox(
                                        height: 47,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: TextField(
                                          controller: feet,
                                          cursorHeight: 18,
                                          cursorColor: AppColors.primaryColor,
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
                                            hintText: 'Inches',
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
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                                title: "Weight",
                                controller: weight,
                                color: AppColors.primaryColor,
                                stateProvider: enteredWeightProvider),
                            const SizedBox(
                              height: 30,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
