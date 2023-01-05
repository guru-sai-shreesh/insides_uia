import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/screens/homescreen/homescreen.dart';
import 'package:insides/services/health/fit_sync_service.dart';

class FitSync extends StatefulWidget {
  const FitSync({Key? key}) : super(key: key);

  @override
  State<FitSync> createState() => _FitSyncState();
}

class _FitSyncState extends State<FitSync> {
  late String _now;
  late Timer _everySecond;

  @override
  void initState() {
    super.initState();

    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
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
              if (requested.toString() == 'true') {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: (requested.toString() == 'true')
                    ? LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      )
                    : LinearGradient(
                        colors: <Color>[
                          Colors.grey,
                          Color.fromARGB(255, 190, 190, 190),
                        ],
                      ),
              ),
              margin: EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 5),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 45,
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
                title: Text(
                  "Google Fit Sync",
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Padding(
                  //   padding: EdgeInsets.only(left: 15, top: 30, right: 15),
                  //   child: Text(
                  //     "ACTIVITY",
                  //     style: GoogleFonts.openSans(
                  //         fontSize: 20,
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w700),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                      icon: SvgPicture.asset('assets/images/google.svg'),
                      onPressed: () async {
                        await syncPerm();
                      },
                      label: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Sync with Google fit',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
