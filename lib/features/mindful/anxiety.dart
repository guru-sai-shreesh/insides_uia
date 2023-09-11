import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/colors.dart';

AudioPlayer audioPlugin = AudioPlayer();

class Anxiety extends StatefulWidget {
  const Anxiety({Key? key}) : super(key: key);

  @override
  State<Anxiety> createState() => _AnxietyState();
}

class _AnxietyState extends State<Anxiety> {
  Timer? timer;
  Duration duration = Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int req = 0;
  }

  void startSleep() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final add = 1;
    setState(() {
      final seconds = duration.inSeconds + add;
      duration = Duration(seconds: seconds);
    });
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
                            'Stop Therapy',
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
        : GestureDetector(
            onTap: () {
              setState(() {
                startSleep();
              });
              audioPlugin.play(UrlSource(
                  "https://cdn.freesound.org/previews/647/647581_5674468-lq.mp3"));
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
                        'Start Therapy',
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
                    '80 bpm',
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
                      'Average Sleep HR: ',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    '85 bpm',
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildButtons(),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Useful Articles",
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 110,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfgnCqVdoAFM7y39SJ5e79yR7uuyh0X-2GXQ&usqp=CAU"),
                              fit: BoxFit.cover)),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
