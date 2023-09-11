import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';

import '../../model/colors.dart';
import '../fitness/services/remote/fetch_health_data.dart';

AudioPlayer audioPlugin = AudioPlayer();

class Meditation extends StatefulWidget {
  const Meditation({Key? key}) : super(key: key);

  @override
  State<Meditation> createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  TextEditingController med_course = TextEditingController();
  Timer? timer;
  Duration duration = Duration();
  double heart_rate_sum = 0;
  int n = 0;
  Timer? hr_timer;
  late String avg_hr;
  HealthDataPoint? sleep_hr;

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

  void startMed() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    hr_timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      HealthDataPoint? hr;

      hr = await FetchHealthData().fetchHR();
      if ((hr?.value).toString() != "null") {
        sleep_hr = hr;
      }
      if (hr?.value != null) {
        heart_rate_sum += double.parse((hr?.value).toString()).round();
        n += 1;
      }
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
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    return Padding(
      padding: const EdgeInsets.only(top: 30),
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
        ? GestureDetector(
            onTap: () {
              setState(() {
                timer!.cancel();
                duration = Duration();
                audioPlugin.stop();
              });
            },
            child: Column(
              children: [
                Card(
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
                            'Stop Meditaion',
                            style: GoogleFonts.openSans(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ))),
                buildSleepCard()
              ],
            ),
          )
        : Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    startMed();
                  });
                  audioPlugin.play(UrlSource(
                      "https://serene-binauralbeats-bucket.s3.amazonaws.com/guided+meditation/10-Minute+Daily+Meditation.mp3"));
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
                            'Start Meditation',
                            style: GoogleFonts.openSans(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ))),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage("assets/images/med.jpg"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          );
  }

  Widget buildSleepCard() {
    return Column(
      children: [
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
                      'Heart Rate: ',
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
                      'Average Heart Rate: ',
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
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  int a = 1;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTimer(),
          // Padding(
          //   padding: const EdgeInsets.only(left: 5, bottom: 5),
          //   child: Text(
          //     "Select Medition Course",
          //     style: GoogleFonts.openSans(
          //       fontSize: 13,
          //       fontWeight: FontWeight.w700,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 47,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: med_course,
                cursorHeight: 18,
                cursorColor: AppColors.primaryColor,
                readOnly: true,
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                onTap: () {
                  showBottomSheet(
                      context: context,
                      // radius: 20,
                      builder: (context) {
                        List<String> options = [
                          "Daily Meditation",
                          "Meditation for sleep",
                          "Meditation for Anger management",
                          "Meditation to start your day",
                          "Peace while walking"
                        ];
                        var selectedIndex;
                        int min = 1, max = 3;
                        Random rnd = new Random();
                        selectedIndex = min + rnd.nextInt(max - min);
                        return Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      150.0, 10.0, 150.0, 20.0),
                                  child: Container(
                                    height: 8.0,
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Select Meditation Course",
                                    style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter mystate) {
                              return Container(
                                padding: EdgeInsets.only(top: 75, bottom: 50),
                                child: ListView.builder(
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(options[index]),
                                          // title: Text(options[selectedIndex]),
                                          leading: (selectedIndex == index)
                                              ? Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.cardcolor,
                                                )
                                              : Icon(Icons.circle_outlined),
                                          onTap: () {
                                            selectedIndex = index;
                                            mystate(() {
                                              selectedIndex = index;
                                            });
                                          },
                                        ),
                                        Divider()
                                      ],
                                    );
                                  },
                                ),
                              );
                            }),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: TextButton(
                                  onPressed: () {
                                    med_course.text = options[selectedIndex];
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                        color: AppColors.cardcolor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: Text(
                                        "Select",
                                        style: GoogleFonts.openSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        );
                      });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.black,
                  ),
                  hintStyle: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                  hintText: 'Select Course',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
            ),
          ),
          buildButtons(),
        ],
      ),
    );
  }
}
