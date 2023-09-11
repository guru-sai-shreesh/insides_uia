import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/colors.dart';

class SleepData extends StatefulWidget {
  const SleepData({Key? key}) : super(key: key);

  @override
  State<SleepData> createState() => _SleepDataState();
}

class _SleepDataState extends State<SleepData> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Text(
              "SLEEP ACTIVITY",
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            color: AppColors.cardcolor.withOpacity(0.9),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 125,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          "TOTAL SLEEP TIME ",
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "4h 59min",
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              color: Colors.white60,
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
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Awake: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '10 min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Light Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '2hr 41min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Deep Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '1hr 5min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'REM Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '1hr 13min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            color: AppColors.cardcolor.withOpacity(0.9),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 125,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          "TOTAL SLEEP TIME ",
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "4h 59min",
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              color: Colors.white60,
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
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Awake: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '10 min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Light Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '2hr 41min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Deep Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '1hr 5min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'REM Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '1hr 13min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            color: AppColors.cardcolor.withOpacity(0.9),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 125,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          "TOTAL SLEEP TIME ",
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "4h 59min",
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              color: Colors.white60,
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
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Awake: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '10 min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Light Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '2hr 41min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'Deep Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '1hr 5min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: Text(
                          'REM Sleep: ',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '1hr 13min',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
