import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/model/diseases.dart';
import 'package:insides/screens/dashboard/add_problem/problem_questionnnaire.dart';
import 'package:insides/widget/custom_tab_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalView extends StatefulWidget {
  final Hospital hospital;
  const HospitalView({Key? key, required this.hospital}) : super(key: key);

  @override
  State<HospitalView> createState() => _HospitalViewState(hospital);
}

class _HospitalViewState extends State<HospitalView>
    with TickerProviderStateMixin {
  final Uri _url = Uri.parse('https://flutter.dev');
  Future<void> openUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Container(
        margin: EdgeInsets.only(right: 23),
        child: Text("Hospital Information"),
      ),
    ),
    Tab(
      child: Container(
        margin: EdgeInsets.only(right: 23),
        child: Text("Tests"),
      ),
    ),
  ];

  final Hospital hospital;

  _HospitalViewState(this.hospital);

  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: myTabs.length, vsync: this);
    return Scaffold(
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
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => PredictionTest(
            //           disease_id: 1,
            //         )));
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
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
      body: Container(
        color: AppColors.cardcolor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: AppColors.cardcolor,
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
              flexibleSpace: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://img.freepik.com/free-vector/people-walking-sitting-hospital-building-city-clinic-glass-exterior-flat-vector-illustration-medical-help-emergency-architecture-healthcare-concept_74855-10130.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Text(
                              hospital.name,
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 25,
                        margin: EdgeInsets.only(top: 5),
                        child: DefaultTabController(
                          length: myTabs.length,
                          child: TabBar(
                            controller: _tabController,
                            labelPadding: EdgeInsets.all(0),
                            indicatorPadding: EdgeInsets.all(0),
                            isScrollable: true,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            labelStyle: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            indicator: RoundedRectangleTabIndicator(
                                weight: 2, width: 10, color: Colors.black),
                            unselectedLabelStyle: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            tabs: myTabs,
                          ),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 700,
                        child:
                            TabBarView(controller: _tabController, children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25, right: 25),
                            child: Container(
                              width: MediaQuery.of(context).size.height - 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address:",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(hospital.address),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Website:",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(hospital.website),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Email:",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(hospital.email),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Mobile No:",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(hospital.phone),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rating:",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(hospital.rating.toString()),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ABG",
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
