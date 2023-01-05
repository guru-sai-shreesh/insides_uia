import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/screens/dashboard/add_problem/hospital_select/hospitals_list.dart';

class PredictionTest extends StatefulWidget {
  final int disease_id;
  const PredictionTest({Key? key, required this.disease_id}) : super(key: key);

  @override
  State<PredictionTest> createState() => _PredictionTestState(disease_id);
}

class _PredictionTestState extends State<PredictionTest> {
  List<String> tests = ["Arterial Blood Gas", "Spirometry Test"];

  bool isLoading = false;

  final int disease_id;

  late TextEditingController controller = TextEditingController();

  _PredictionTestState(this.disease_id);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 234, 234, 234),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Predicted Diseases",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HospitalList()));
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
                    'Select Hospital',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("COPD:"),
                                      Spacer(),
                                      Text(
                                        "Positive(+ve)",
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(),
                                ],
                              );
                            }),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "Recomended Tests",
                  style: GoogleFonts.openSans(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tests.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          color: Color.fromARGB(255, 233, 106, 97),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 60,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: (() {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //   builder: ((context) => DisplayBook(
                                    //         popularBookModel: inNewTab[index] ??
                                    //             Book(
                                    //                 author_name: "author_name",
                                    //                 book_name: "book_name",
                                    //                 isbn: "isbn"),
                                    //       )),
                                    // ));
                                  }),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          tests[index],
                                          style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "Test status: --",
                                          style: GoogleFonts.openSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          )),
    );
  }
}
