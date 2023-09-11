import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:http/http.dart' as http;

import '../../model/colors.dart';
import '../fitness/services/remote/fetch_health_data.dart';

AudioPlayer audioPlugin = AudioPlayer();

class TrackSleep extends StatefulWidget {
  const TrackSleep({Key? key}) : super(key: key);

  @override
  State<TrackSleep> createState() => _TrackSleepState();
}

class _TrackSleepState extends State<TrackSleep> {
  double heart_rate_sum = 0;
  int n = 0;
  Timer? timer;
  // Timer? hr_timer;
  Timer? classifier_timer;
  Duration duration = Duration();
  late String avg_hr;
  HealthDataPoint? sleep_hr;
  late int awake = 0;
  late int light = 0;
  late int deep = 0;
  late String nowPlaying = "Beta (Awake Stage)";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch_hr();
    setState(() {});
  }

  fetch_hr() async {
    sleep_hr = await FetchHealthData().fetchHR();
    if (sleep_hr?.value != null) {
      heart_rate_sum += double.parse((sleep_hr?.value).toString()).round();
      n += 1;
    }
  }

  void startSleep() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      addTime();
    });
    // hr_timer = Timer.periodic(Duration(minutes: 1), (timer) {
    //   print("hr sent");
    // });
    fetch_hr();
    classifier_timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      HealthDataPoint? hr;

      hr = await FetchHealthData().fetchHR();
      if ((hr?.value).toString() != "null") {
        sleep_hr = hr;
      }
      if (hr?.value != null) {
        heart_rate_sum += double.parse((hr?.value).toString()).round();
        n += 1;
      }
      var url =
          'https://4dp7pxvi2f.execute-api.us-east-1.amazonaws.com/dev/sleep-stage';
      http.Response result = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'data': ((sleep_hr?.value).toString() == "null")
              ? "0"
              : double.parse((sleep_hr?.value).toString()).round().toString() +
                  ", 1"
        }),
      );
      switch (result.body) {
        case "0":
          awake += 1;
          audioPlugin.play(UrlSource(
              "https://serene-binauralbeats-bucket.s3.amazonaws.com/beta.mp3"));
          nowPlaying = "Beta (Awake Stage)";
          break;
        case "1":
          light += 1;
          audioPlugin.play(UrlSource(
              "https://serene-binauralbeats-bucket.s3.amazonaws.com/theta.mp3"));
          nowPlaying = "gamma (Light Stage)";
          break;
        case "2":
          deep += 1;
          audioPlugin.play(UrlSource(
              "https://serene-binauralbeats-bucket.s3.amazonaws.com/delta.mp3"));
          nowPlaying = "delta (Deep/REM Stage)";
          break;
      }
      print(result.body);
    });
  }

  void addTime() {
    final add = 1;
    setState(() {
      final seconds = duration.inSeconds + add;
      duration = Duration(seconds: seconds);
    });
  }

  Widget buildTimer() {
    final hours = duration.inHours.remainder(99).toString().padLeft(2, "0");
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: Text(
                  hours,
                  style: GoogleFonts.openSans(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "hrs",
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: Text(
                  minutes,
                  style: GoogleFonts.openSans(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "min",
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: Text(
                  seconds,
                  style: GoogleFonts.openSans(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "sec",
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtons() {
    final running = timer == null ? false : timer!.isActive;
    return running
        ? Column(
            children: [
              GestureDetector(
                onTap: () {
                  audioPlugin.stop();
                  setState(() {
                    timer!.cancel();
                    // hr_timer!.cancel();
                    classifier_timer!.cancel();
                    duration = Duration();

                    heart_rate_sum = 0;
                    n = 0;
                    awake = 0;
                    light = 0;
                    deep = 0;
                  });
                },
                child: Card(
                    margin: EdgeInsets.all(20),
                    color: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Center(
                          child: Text(
                            'Stop Sleep',
                            style: GoogleFonts.openSans(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ))),
              ),
              buildSleepCard()
            ],
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                startSleep();
              });
              audioPlugin.play(UrlSource(
                  "https://serene-binauralbeats-bucket.s3.amazonaws.com/beta.mp3"));
            },
            child: Card(
                margin: EdgeInsets.all(20),
                color: AppColors.cardcolor.withOpacity(0.9),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Center(
                      child: Text(
                        'Start Sleep',
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ))),
          );
  }

  Widget buildSleepCard() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          height: 45,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.cardcolor.withOpacity(0.5)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 0),
                    child: Text(
                      'Now Playing: ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    nowPlaying,
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          height: 80,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.cardcolor.withOpacity(0.5)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 0),
                    child: Text(
                      'Sleep Heart Rate: ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    ((sleep_hr?.value).toString() == "null")
                        ? "No Record"
                        : (sleep_hr?.value).toString(),
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' bpm',
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 0),
                    child: Text(
                      "Average Heart Rate: ",
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    (heart_rate_sum / n).toStringAsFixed(1),
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' bpm',
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          height: 175,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.cardcolor.withOpacity(0.5)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 0),
                    child: Text(
                      'Awake: ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    '0',
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'hr ',
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    awake.toString(),
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'min',
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      'Light Sleep: ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '0',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'hr ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      light.toString(),
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'min',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      'Deep Sleep: ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '0',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'hr ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      deep.toString(),
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'min',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      'REM Sleep: ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '0',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'hr ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      (deep.toDouble() / 5).toStringAsFixed(0),
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'min',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, top: 30, right: 15),
            child: Text(
              "Binaural Sleep Tracking",
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: AppColors.cardcolor,
                  fontWeight: FontWeight.w700),
            ),
          ),
          buildTimer(),
          buildButtons()
        ],
      ),
    );
  }
}
