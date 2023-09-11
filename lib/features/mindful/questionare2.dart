import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/colors.dart';
import 'questionare3.dart';

class Questionare2 extends StatefulWidget {
  const Questionare2({Key? key}) : super(key: key);

  @override
  _Questionare2State createState() => _Questionare2State();
}

class _Questionare2State extends State<Questionare2> {
  @override
  Widget build(BuildContext context) {
    TextEditingController q1 = TextEditingController();
    return Container(
      color: Color.fromARGB(255, 244, 242, 242),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "What's typically the biggest source of stress for you? ",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            controller: q1,
                            cursorHeight: 18,
                            cursorColor: AppColors.primaryColor,
                            readOnly: true,
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            onTap: () {
                              showBottomSheet(
                                  context: context,
                                  // radius: 20,
                                  builder: (context) {
                                    List<String> options = [
                                      "Work",
                                      "Relationships",
                                      "Family",
                                      "money",
                                    ];
                                    var selectedIndex;
                                    return Stack(
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
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                "Source of Stress?",
                                                style: GoogleFonts.openSans(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
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
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      title:
                                                          Text(options[index]),
                                                      leading: (selectedIndex ==
                                                              index)
                                                          ? Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color: AppColors
                                                                  .cardcolor,
                                                            )
                                                          : Icon(Icons
                                                              .circle_outlined),
                                                      onTap: () {
                                                        selectedIndex = index;
                                                        mystate(() {
                                                          selectedIndex = index;
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
                                          alignment: Alignment.bottomCenter,
                                          child: TextButton(
                                              onPressed: () {
                                                q1.text =
                                                    options[selectedIndex];
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 45,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                decoration: BoxDecoration(
                                                    color: AppColors.cardcolor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Center(
                                                  child: Text(
                                                    "Select",
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
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
                                  color: Colors.black,
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
                              hintText: 'Select Option',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
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
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Questionare3()));
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
