import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/model/diseases.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';
import 'package:insides/screens/dashboard/add_problem/add_problem.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

int count = 0;

class _DashboardState extends State<Dashboard> {
  var url = "http://localhost:3000/disease_categories";
  List<DiseaseCategory> categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // classifier_timer = Timer.periodic(Duration(seconds: 2), (timer) async {
    //   _fetchData();
    // }
    // );
  }

  _fetchData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      categories = diseaseCategoryFromJson(response.body);
    }
    return 1;
  }

  Widget _buildMedicalProblems() {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Add Medical Problems",
                style: GoogleFonts.openSans(
                    color: ColourManager.black,
                    fontSize: FontSizeManager.f_14,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 14,
              )
            ],
          ),
          SizedBox(
            height: 250.0,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) => Card(
                color: AppColors.cardcolor,
                elevation: 5,
                margin: EdgeInsets.only(bottom: 10, right: 10, top: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AddProblem(diseaseCat: categories[index])));
                        }),
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      NetworkImage(categories[index].photoUrl),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Container(
                          // margin: EdgeInsets.only(right: 35),
                          padding:
                              EdgeInsets.only(left: 15, top: 10, right: 15),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: categories[index].name,
                                ),
                              ],
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(left: 15, top: 2, right: 15),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Common Symtoms: ',
                                  style: TextStyle(
                                      fontSize: 11.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: categories[index].symptoms,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        decoration: BoxDecoration(),
                        height: 40,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                BorderSide(width: 2.0, color: Colors.white)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            minimumSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width - 80, 35)),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AddProblem(diseaseCat: categories[index])));
                          },
                          child: Text(
                            "ADD PROBLEM ",
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ButtonTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourProblems() {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Problem Status",
            style: GoogleFonts.openSans(
                color: ColourManager.black,
                fontSize: FontSizeManager.f_14,
                fontWeight: FontWeight.w500),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 0),
              // itemCount: cart.length(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
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
                              width: 60,
                              padding: EdgeInsets.only(
                                left: 10,
                                top: 2,
                                bottom: 2,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPSM1DCultEUCW8NdVYoCOabi81Tbha0X5mbviXrsNBt01p6yzPhR-1-3J0ab8Hd1JQwQ&usqp=CAU"),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Poblem Id/Name",
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
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Date of issue: ',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: '10-11-22',
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
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Predicted diseases: ',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: 'Astma, COPD',
                                          ),
                                        ],
                                      ),
                                    )),
                                Spacer(),
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 2, bottom: 10),
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 11.5,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Status: ',
                                            style: TextStyle(
                                                fontSize: 11.5,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: 'Pre-assesment test done',
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Icon(Icons.more_horiz),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildYourAppointments() {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Appointments",
            style: GoogleFonts.openSans(
                color: ColourManager.black,
                fontSize: FontSizeManager.f_14,
                fontWeight: FontWeight.w500),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 0),
              // itemCount: cart.length(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
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
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
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
                            width: MediaQuery.of(context).size.width - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Test Name/Doctor name",
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
                                            fontSize: 11.5,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Appointment Date: ',
                                            style: TextStyle(
                                                fontSize: 11.5,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: '10-11-22',
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
                                            fontSize: 11.5,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Hospital Name: ',
                                            style: TextStyle(
                                                fontSize: 11.5,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: 'Yashodha',
                                          ),
                                        ],
                                      ),
                                    )),
                                Spacer(),
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 2, bottom: 10),
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 11.5,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Status: ',
                                            style: TextStyle(
                                                fontSize: 11.5,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: 'Result out',
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Icon(Icons.more_horiz),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: _fetchData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      floating: false,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      pinned: true,
                      expandedHeight: 70,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        expandedTitleScale: 1.3,
                        titlePadding: EdgeInsets.only(left: 15, bottom: 15),
                        title: Text(
                          "Dashboard",
                          style: GoogleFonts.openSans(
                              color: ColourManager.black,
                              fontSize: FontSizeManager.f_20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications_outlined)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                      ],
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          _buildYourProblems(),
                          _buildMedicalProblems(),
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 204, 204, 204),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SizedBox(
                              height: 35,
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      "Subscriptions",
                                      style: GoogleFonts.openSans(
                                          color: ColourManager.black,
                                          fontSize: FontSizeManager.f_14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          _buildYourAppointments(),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
