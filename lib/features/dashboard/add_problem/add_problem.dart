import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/model/diseases.dart';
import 'package:insides/features/dashboard/add_problem/problem_questionnnaire.dart';
import 'package:insides/components/custom_tab_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class AddProblem extends StatefulWidget {
  final DiseaseCategory diseaseCat;
  const AddProblem({Key? key, required this.diseaseCat}) : super(key: key);

  @override
  State<AddProblem> createState() => _AddProblemState(diseaseCat);
}

class _AddProblemState extends State<AddProblem> with TickerProviderStateMixin {
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
        child: Text("Category Information"),
      ),
    ),
    Tab(
      child: Container(
        margin: EdgeInsets.only(right: 23),
        child: Text("Diseases"),
      ),
    ),
  ];

  final DiseaseCategory diseaseCat;

  _AddProblemState(this.diseaseCat);

  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: myTabs.length, vsync: this);
    return Scaffold(
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
                            image: NetworkImage(diseaseCat.photoUrl),
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
                              diseaseCat.name + " Problems",
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProblemQuestionnaire(
                                      diseaseId: diseaseCat.id)));
                            },
                            child: Text("ADD PROBLEM"),
                          ),
                        ],
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
                                    "Description:",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(diseaseCat.description),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Symptoms:",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(diseaseCat.symptoms),
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
                                  'COPD',
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
