import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';
import 'package:insides/services/health/fetch_health_data.dart';
import 'package:insides/widget/circular_progress_indicator.dart';

class Fitness extends StatefulWidget {
  const Fitness({Key? key}) : super(key: key);

  @override
  State<Fitness> createState() => _FitnessState();
}

int count = 0;

class _FitnessState extends State<Fitness> {
  int? steps;
  int? Wsteps;
  HealthDataPoint? height;
  HealthDataPoint? weight;
  HealthDataPoint? heart_rate;
  HealthDataPoint? bp_systolic;
  HealthDataPoint? bp_diastolic;
  Timer? classifier_timer;

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
    height = await FetchHealthData().fetchHeight();
    weight = await FetchHealthData().fetchWeight();
    heart_rate = await FetchHealthData().fetchHR();
    Wsteps = await FetchHealthData().fetchWNoStep();
    steps = await FetchHealthData().fetchNoStep();
    bp_systolic = await FetchHealthData().bloodPreasureSystolic();
    bp_diastolic = await FetchHealthData().bloodPreasureDiastolic();
    return 1;
    // count++;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: _fetchData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
                          "Fitness",
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
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15, top: 0, right: 15, bottom: 5),
                            child: Text(
                              "TODAY'S GOAL",
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            height: 190,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // color: AppColors.badgecolor,
                                borderRadius: BorderRadius.circular(25)),
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Center(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: RadialProgress(
                                      height: 160.0,
                                      width: 160.0,
                                      progress: (steps ?? 0).toDouble() / 200,
                                      steps_left: 200 - (steps ?? 0).toInt(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, right: 15),
                            child: Text(
                              "ACTIVITY",
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(10),
                            color: AppColors.cardcolor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "STEPS COUNT",
                                          style: GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Show All",
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15, top: 10),
                                    width: 300,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value:
                                            ((Wsteps ?? 0).toDouble()) / 1000,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                        backgroundColor:
                                            Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, top: 0, right: 15),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: Wsteps.toString(),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 34,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextSpan(
                                                      text: ' of 1400 Steps',
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 0, right: 15),
                                            child: Text(
                                              'Last 7 days',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  color: Colors.white60,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Icon(
                                          Icons.run_circle,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            color: AppColors.cardcolor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, top: 10, right: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Calories Burned",
                                            style: GoogleFonts.openSans(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Just Now",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.white60,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    top: 2,
                                                    right: 15),
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '284 ',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                fontSize: 34,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      TextSpan(
                                                        text: 'Cal',
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Text(
                                                'Today',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 14,
                                                    color: Colors.white60,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, right: 15),
                            child: Text(
                              "HEART",
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(10),
                            color: AppColors.cardcolor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "HEART RATE",
                                          style: GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Just Now",
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, top: 2, right: 15),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: ((heart_rate?.value)
                                                                  .toString() ==
                                                              "null")
                                                          ? "No Record"
                                                          : (heart_rate?.value)
                                                              .toString(),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 32,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextSpan(
                                                      text: ((heart_rate?.value)
                                                                  .toString() ==
                                                              "null")
                                                          ? ""
                                                          : " BPM",
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 0, right: 15),
                                            child: Text(
                                              'NORMAL',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  color: Colors.white60,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            color: AppColors.cardcolor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "BLOOD PRESURE",
                                          style: GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Just Now",
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, top: 2, right: 15),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: ((bp_systolic
                                                                      ?.value)
                                                                  .toString() ==
                                                              "null")
                                                          ? "--"
                                                          : (bp_systolic?.value)
                                                              .toString(),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 32,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextSpan(
                                                      text: '/',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 32,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextSpan(
                                                      text: ((bp_diastolic
                                                                      ?.value)
                                                                  .toString() ==
                                                              "null")
                                                          ? "--"
                                                          : (bp_diastolic
                                                                  ?.value)
                                                              .toString(),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 32,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 0, right: 15),
                                            child: Text(
                                              'NORMAL',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  color: Colors.white60,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(right: 30),
                                      //   child: Icon(
                                      //     Icons.favorite,
                                      //     color: Colors.white,
                                      //     size: 40,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, right: 15),
                            child: Text(
                              "BODY",
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(10),
                            color: AppColors.cardcolor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "BMI",
                                          style: GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Just Now",
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, top: 2, right: 15),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: ((weight?.value)
                                                                      .toString() ==
                                                                  "null" ||
                                                              (height?.value)
                                                                      .toString() ==
                                                                  "null")
                                                          ? "--"
                                                          : (double.parse((weight
                                                                          ?.value)
                                                                      .toString()) /
                                                                  (double.parse(
                                                                          (height?.value)
                                                                              .toString()) *
                                                                      double.parse(
                                                                          (height?.value).toString())))
                                                              .toStringAsFixed(2),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 34,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextSpan(
                                                      text: '',
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 0, right: 15),
                                            child: Text(
                                              'NORMAL',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  color: Colors.white60,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(right: 30),
                                      //   child: Icon(
                                      //     Icons.favorite,
                                      //     color: Colors.white,
                                      //     size: 40,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            color: AppColors.cardcolor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "HEIGHT",
                                          style: GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Just Now",
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, top: 2, right: 15),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: ((height?.value)
                                                                  .toString() ==
                                                              "null")
                                                          ? "No Record"
                                                          : (double.parse((height
                                                                          ?.value)
                                                                      .toString()) *
                                                                  100 /
                                                                  30.48)
                                                              .floor()
                                                              .toString(),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 34,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextSpan(
                                                      text: 'ft ',
                                                    ),
                                                    TextSpan(
                                                      text: ((height?.value)
                                                                  .toString() ==
                                                              "null")
                                                          ? "No Record"
                                                          : (((double.parse((height?.value)
                                                                              .toString()) *
                                                                          100 /
                                                                          30.48) -
                                                                      (double.parse((height?.value).toString()) *
                                                                              100 /
                                                                              30.48)
                                                                          .floor()) *
                                                                  10)
                                                              .toStringAsFixed(
                                                                  0),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 34,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextSpan(
                                                      text: 'in',
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            color: AppColors.cardcolor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Weight",
                                          style: GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Just Now",
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, top: 2, right: 15),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: ((weight?.value)
                                                                  .toString() ==
                                                              "No Record")
                                                          ? "--"
                                                          : double.parse((weight
                                                                      ?.value)
                                                                  .toString())
                                                              .toStringAsFixed(
                                                                  2),
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 34,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextSpan(
                                                      text: 'kg',
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
