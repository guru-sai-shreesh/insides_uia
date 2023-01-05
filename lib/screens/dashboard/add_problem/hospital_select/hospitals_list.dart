import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/diseases.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';
import 'package:insides/screens/dashboard/add_problem/hospital_select/hospital_view.dart';
import 'package:http/http.dart' as http;

class HospitalList extends StatefulWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  var url = "http://localhost:3000/hospitals";
  List<Hospital> hospitals = [];

  _fetchData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      hospitals = hospitalFromJson(response.body);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospitals Services"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: _fetchData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 0),
                        // itemCount: cart.length(),
                        itemCount: hospitals.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HospitalView(
                                      hospital: hospitals[index])));
                            },
                            child: Card(
                              color: Color.fromARGB(255, 204, 204, 204),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 90,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                      ),
                                      elevation: 0,
                                      child: Container(
                                        height: 90,
                                        width: 70,
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://img.freepik.com/free-vector/people-walking-sitting-hospital-building-city-clinic-glass-exterior-flat-vector-illustration-medical-help-emergency-architecture-healthcare-concept_74855-10130.jpg"),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            hospitals[index].name,
                                            style: GoogleFonts.openSans(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                              padding: EdgeInsets.only(
                                                top: 2,
                                              ),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Mobile Number: ',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    TextSpan(
                                                      text: hospitals[index]
                                                          .phone,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Spacer(),
                                          Container(
                                              padding: EdgeInsets.only(
                                                top: 2,
                                              ),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Rating: ',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    TextSpan(
                                                      text: hospitals[index]
                                                          .rating
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Spacer(),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 2, bottom: 10),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                      fontSize: 11.5,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Estimated Cost: ',
                                                      style: TextStyle(
                                                          fontSize: 11.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    TextSpan(
                                                      text: "1200",
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
