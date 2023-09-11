import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/model/diseases.dart';
import 'package:insides/features/dashboard/add_problem/prediction_test.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class ProblemQuestionnaire extends StatefulWidget {
  final int diseaseId;
  const ProblemQuestionnaire({Key? key, required this.diseaseId})
      : super(key: key);

  @override
  _ProblemQuestionnaireState createState() =>
      _ProblemQuestionnaireState(diseaseId);
}

class _ProblemQuestionnaireState extends State<ProblemQuestionnaire> {
  final int diseaseId;

  _ProblemQuestionnaireState(this.diseaseId);

  TextEditingController q1 = TextEditingController();
  TextEditingController q2 = TextEditingController();
  TextEditingController q3 = TextEditingController();
  TextEditingController q4 = TextEditingController();
  TextEditingController q5 = TextEditingController();
  TextEditingController q6 = TextEditingController();
  TextEditingController q7 = TextEditingController();
  TextEditingController q8 = TextEditingController();
  TextEditingController q9 = TextEditingController();
  TextEditingController q10 = TextEditingController();
  TextEditingController q11 = TextEditingController();
  TextEditingController q12 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildPopupTF(
      String question, List<String> options, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 8),
          child: Text(
            question,
            style: GoogleFonts.openSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 47,
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: controller,
            cursorHeight: 18,
            cursorColor: AppColors.primaryColor,
            readOnly: true,
            style: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            onTap: () {
              showMaterialModalBottomSheet(
                  context: context,
                  // radius: 20,
                  builder: (context) {
                    var selectedIndex;
                    return Container(
                      height: 600,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    150.0, 10.0, 150.0, 20.0),
                                child: Container(
                                  height: 8.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Select ",
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
                              (BuildContext context, StateSetter mystate) {
                            return Container(
                              padding: EdgeInsets.only(top: 75, bottom: 50),
                              child: ListView.builder(
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(options[index]),
                                        leading: (selectedIndex == index)
                                            ? Icon(
                                                Icons.check_circle,
                                                color: Color(0xFF0D47A1),
                                              )
                                            : Icon(Icons.circle_outlined),
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
                            child: OutlinedButton(
                                onPressed: () {
                                  controller.text = options[selectedIndex];
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0D47A1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "Save",
                                      style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
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
              suffixIcon: Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.black,
              ),
              hintStyle: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
              hintText: 'Select Gender',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
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
        appBar: AppBar(
          title: Text(
            "QUESTIONNAIRE",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
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
                      _buildPopupTF(
                          "1. How severe is your cough ?",
                          [
                            "Grade 0",
                            "Grade 1",
                            "Grade 2",
                            "Grade 3",
                            "Grade 4",
                            "Grade 5"
                          ],
                          q1),
                      _buildPopupTF(
                          "2. Do you have any phlegm in your chest ?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q2),
                      _buildPopupTF(
                          "3. How tight does your chest feel ?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q3),
                      _buildPopupTF(
                          "4. When you walk up on a hill or one flight of stairs how breathless you feel ?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q4),
                      _buildPopupTF(
                          "5. Are you limited doing any activities at home ?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q5),
                      _buildPopupTF(
                          "6. HHow confident you feel leaving your home despite your lung condition ?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q6),
                      _buildPopupTF(
                          "7. How well your sleep is ?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q7),
                      _buildPopupTF(
                          "8. How energetic you feel ?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q8),
                      _buildPopupTF(
                          "9. How often do you cough?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q9),
                      _buildPopupTF(
                          "10. How often do you cough?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q10),
                      _buildPopupTF(
                          "11. How often do you cough?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q11),
                      _buildPopupTF(
                          "12. How often do you cough?",
                          [
                            "option 1",
                            "option 2",
                            "option 3",
                            "option 4",
                            "option 5",
                            "option 6"
                          ],
                          q12),
                    ]),
              ),
            ),
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PredictionTest(
                        disease_id: 1,
                      )));
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
