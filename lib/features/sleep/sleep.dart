import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_tab_indicator.dart';
import 'sleep_data.dart';
import 'track_sleep.dart';

class Sleep extends StatefulWidget {
  const Sleep({Key? key}) : super(key: key);

  @override
  State<Sleep> createState() => _SleepState();
}

class _SleepState extends State<Sleep> with TickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Container(
        margin: EdgeInsets.only(right: 23),
        child: Text("Track Sleep"),
      ),
    ),
    Tab(
      child: Container(
        margin: EdgeInsets.only(right: 23),
        child: Text("Sleep Data"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

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
              expandedHeight: 70,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                expandedTitleScale: 1.3,
                titlePadding: EdgeInsets.only(left: 15, bottom: 15),
                title: Text("Sleep"),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.add)),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 25,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(left: 15),
                    child: DefaultTabController(
                      length: 2,
                      child: TabBar(
                        controller: _tabController,
                        labelPadding: EdgeInsets.all(0),
                        indicatorPadding: EdgeInsets.all(0),
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        indicator: RoundedRectangleTabIndicator(
                            weight: 2, width: 10, color: Colors.black),
                        unselectedLabelStyle: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        tabs: myTabs,
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height - 100,
                    child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        controller: _tabController,
                        children: [
                          TrackSleep(),
                          SleepData(),
                        ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
