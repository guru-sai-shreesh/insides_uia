import 'package:flutter/material.dart';
import 'package:insides/model/colors.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:rounded_modal/rounded_modal.dart';

import 'package:google_fonts/google_fonts.dart';

File file = File("your initial file");

class MyRegister2 extends StatefulWidget {
  const MyRegister2({Key? key}) : super(key: key);

  @override
  _MyRegister2State createState() => _MyRegister2State();
}

class _MyRegister2State extends State<MyRegister2> {
  TextEditingController institution_name = TextEditingController();
  TextEditingController roll_no = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController qualification = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      // ),
      color: Color.fromARGB(255, 244, 242, 242),
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "E-VCE",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.transparent,
        //   iconTheme: IconThemeData(color: Colors.black),
        //   elevation: 0,
        // ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding:
                    EdgeInsets.only(top: 50, right: 15, left: 15, bottom: 70),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: (() {
                                Navigator.pop(context);
                              }),
                              icon: Icon(Icons.arrow_back_ios)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 5),
                                child: Text(
                                  "EDUCATIONAL QUALIFICATION",
                                  style: GoogleFonts.openSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 47,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: TextField(
                                  controller: qualification,
                                  cursorHeight: 18,
                                  cursorColor: AppColors.primaryColor,
                                  readOnly: true,
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  onTap: () {
                                    showRoundedModalBottomSheet(
                                        context: context,
                                        radius: 20,
                                        builder: (context) {
                                          List<String> options = [
                                            "High School",
                                            "Intermediate",
                                            "Graduation",
                                            "Post Graduation",
                                            "Other"
                                          ];
                                          var selectedIndex;
                                          return Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(150.0,
                                                        10.0, 150.0, 20.0),
                                                    child: Container(
                                                      height: 8.0,
                                                      width: 80.0,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: Text(
                                                      "Educational Qualification",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                              StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter mystate) {
                                                return Container(
                                                  padding: EdgeInsets.only(
                                                      top: 75, bottom: 50),
                                                  child: ListView.builder(
                                                    itemCount: options.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                            title: Text(
                                                                options[index]),
                                                            leading:
                                                                (selectedIndex ==
                                                                        index)
                                                                    ? Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color: Color(
                                                                            0xFF0D47A1),
                                                                      )
                                                                    : Icon(Icons
                                                                        .circle_outlined),
                                                            onTap: () {
                                                              selectedIndex =
                                                                  index;
                                                              mystate(() {
                                                                selectedIndex =
                                                                    index;
                                                              });
                                                            },
                                                          ),
                                                          Divider()
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                );
                                              }),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: FlatButton(
                                                    onPressed: () {
                                                      qualification.text =
                                                          options[
                                                              selectedIndex];
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF0D47A1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Center(
                                                        child: Text(
                                                          "Save",
                                                          style: GoogleFonts
                                                              .openSans(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          );
                                        });
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
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.black,
                                    ),
                                    hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                    ),
                                    hintText: 'Select Qualification',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 5),
                            child: Text(
                              "INSTITUTION NAME",
                              style: GoogleFonts.openSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 47,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: TextField(
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
                                hintText: 'Enter Institution Name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
                            padding: const EdgeInsets.only(left: 5, bottom: 5),
                            child: Text(
                              "DATE OF JOINING",
                              style: GoogleFonts.openSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 47,
                            width: MediaQuery.of(context).size.width * 0.85,
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
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  helpText: "Date Of Joining",
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
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
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
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
                            padding: const EdgeInsets.only(left: 5, bottom: 5),
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
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: TextField(
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
                                hintText: 'Enter Roll Number',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
                    ]),
              ),
            ),
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
          child: FlatButton(
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => FitSync()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
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
