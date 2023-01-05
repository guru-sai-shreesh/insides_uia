import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/main.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({Key? key}) : super(key: key);

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  late DateTime _selectedDay;

  Map<DateTime, List<CleanCalendarEvent>> event = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent(
        'Log 1',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        description: 'First log',
        color: Colors.pink,
      ),
      CleanCalendarEvent(
        'Log 2',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        description: 'Second log',
        color: Colors.pink,
      ),
    ],
  };

  void _handleData(date) {
    setState(() {
      _selectedDay = date;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                title: Text(
                  "Medical Prescription",
                  style: GoogleFonts.openSans(
                      color: ColourManager.black,
                      fontSize: FontSizeManager.f_20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Calendar(
                        startOnMonday: true,
                        //random colours
                        selectedColor: Colors.blue,
                        todayColor: Colors.orange,
                        eventColor: Colors.red,
                        eventDoneColor: Colors.yellow,
                        bottomBarColor: Colors.brown,
                        dayOfWeekStyle: TextStyle(color: Colors.green),
                        bottomBarTextStyle: TextStyle(color: Colors.white),

                        events: event,
                        isExpanded: true,
                        isExpandable: true,
                        hideArrows: false,
                        hideBottomBar: false,
                        weekDays: [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ],

                        onRangeSelected: (range) {
                          print('selected day: ${range.from}, ${range.to}');
                        },
                        onDateSelected: (date) {
                          return _handleData(date);
                        },
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
