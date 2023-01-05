import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/screens/auth_screens/fit_sync.dart';
import 'package:intl/intl.dart';
import 'package:rounded_modal/rounded_modal.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyRegister(),
    ));

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addresse = TextEditingController();
  TextEditingController feet = TextEditingController();
  TextEditingController inches = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();

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
      color: const Color.fromARGB(255, 244, 242, 242),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "SignUp",
            style: GoogleFonts.openSans(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding:
                const EdgeInsets.only(top: 50, right: 15, left: 15, bottom: 70),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.black54,
                          child: CircleAvatar(
                            radius: 71,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 69,
                              backgroundImage: NetworkImage(
                                  'https://yt3.ggpht.com/ytc/AKedOLRTjSE3cSLWjjTu06H1vmZ3bpTG8SrNONwsfrVh8Q=s900-c-k-c0x00ffffff-no-rj'),
                            ),
                          ),
                        ),
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
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(
                          "FIRST NAME",
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
                          controller: firstname,
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
                            hintText: 'Enter First name',
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
                          "LAST NAME",
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
                          controller: lastname,
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
                            hintText: 'Enter Last name',
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
                              helpText: "Date Of Birth",
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
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
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(
                          "Gender",
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
                          controller: gender,
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
                                  List<String> options = ["Male", "Femele"];
                                  var selectedIndex;
                                  return SizedBox(
                                    height: 300,
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      150.0, 10.0, 150.0, 20.0),
                                              child: Container(
                                                height: 8.0,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                "Assigned Blood group",
                                                style: GoogleFonts.openSans(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                        StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter mystate) {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                top: 75, bottom: 50),
                                            child: ListView.builder(
                                              itemCount: options.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      title:
                                                          Text(options[index]),
                                                      leading: (selectedIndex ==
                                                              index)
                                                          ? const Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color: Color(
                                                                  0xFF0D47A1),
                                                            )
                                                          : const Icon(Icons
                                                              .circle_outlined),
                                                      onTap: () {
                                                        selectedIndex = index;
                                                        mystate(() {
                                                          selectedIndex = index;
                                                        });
                                                      },
                                                    ),
                                                    const Divider()
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        }),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                gender.text =
                                                    options[selectedIndex];
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 45,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF0D47A1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Center(
                                                  child: Text(
                                                    "Save",
                                                    style: GoogleFonts.openSans(
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
                                    ),
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
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.black,
                            ),
                            hintStyle: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                            hintText: 'Select Gender',
                            enabledBorder: const OutlineInputBorder(
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
                          "Blood Group",
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
                          controller: gender,
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
                                    "A+",
                                    "A-",
                                    "B+",
                                    "B-",
                                    "O+",
                                    "O_"
                                  ];
                                  var selectedIndex;
                                  return SizedBox(
                                    height: 300,
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      150.0, 10.0, 150.0, 20.0),
                                              child: Container(
                                                height: 8.0,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                "Assigned Blood group",
                                                style: GoogleFonts.openSans(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                        StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter mystate) {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                top: 75, bottom: 50),
                                            child: ListView.builder(
                                              itemCount: options.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      title:
                                                          Text(options[index]),
                                                      leading: (selectedIndex ==
                                                              index)
                                                          ? const Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color: Color(
                                                                  0xFF0D47A1),
                                                            )
                                                          : const Icon(Icons
                                                              .circle_outlined),
                                                      onTap: () {
                                                        selectedIndex = index;
                                                        mystate(() {
                                                          selectedIndex = index;
                                                        });
                                                      },
                                                    ),
                                                    const Divider()
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        }),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                gender.text =
                                                    options[selectedIndex];
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 45,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF0D47A1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Center(
                                                  child: Text(
                                                    "Save",
                                                    style: GoogleFonts.openSans(
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
                                    ),
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
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.black,
                            ),
                            hintStyle: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                            hintText: 'Select Gender',
                            enabledBorder: const OutlineInputBorder(
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
                          "Email",
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
                          controller: email,
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
                            hintText: 'Enter Email',
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
                          "Phone Number",
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
                          controller: phone,
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
                            hintText: 'Enter Phone Number',
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
                          "Addresse",
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
                          controller: addresse,
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
                            hintText: 'Enter Address',
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
                        padding: const EdgeInsets.only(left: 20, bottom: 5),
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
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 47,
                              width: MediaQuery.of(context).size.width * 0.4,
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
                                  hintText: 'Feet',
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
                            SizedBox(
                              height: 47,
                              width: MediaQuery.of(context).size.width * 0.4,
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
                                  hintText: 'Inches',
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
                          "WEIGHT",
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
                          controller: weight,
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
                            hintText: 'Kilograms',
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
                    height: 30,
                  ),
                ]),
          ),
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FitSync()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: <Color>[
                    AppColors.cardcolor,
                    AppColors.cardcolor,
                    AppColors.cardcolor
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
