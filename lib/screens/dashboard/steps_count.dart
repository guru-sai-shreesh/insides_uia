import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/services/health/fetch_health_data.dart';

class StepsCount extends StatefulWidget {
  const StepsCount({Key? key}) : super(key: key);

  @override
  State<StepsCount> createState() => _StepsCountState();
}

class _StepsCountState extends State<StepsCount> {
  List<HealthDataPoint>? steps;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _fetchData() async {
    steps = await FetchHealthData().fetchWStepData();
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();
    return Container(
      color: Colors.white,
      child: Scaffold(
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
              expandedHeight: 110,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                expandedTitleScale: 1.3,
                titlePadding: EdgeInsets.only(left: 15, bottom: 15),
                title: Text("Dashboard"),
              ),
              actions: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
                IconButton(onPressed: () {}, icon: Icon(Icons.add)),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 30, right: 15),
                    child: Text(
                      "ACTIVITY",
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    color: AppColors.cardcolor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, right: 15),
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
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 15, top: 2, right: 15),
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: steps.toString(),
                                              style: GoogleFonts.openSans(
                                                  fontSize: 34,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            TextSpan(
                                              text: ' of 8000 Steps',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
