import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/main.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:insides/model/colors.dart';

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
        'Paracetamol 1mg',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        description: 'daily',
        color: AppColors.primaryColor,
      ),
      CleanCalendarEvent(
        'Nicotin',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        description: 'daily',
        color: AppColors.primaryColor,
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
                      color: Colors.black,
                      fontSize: 20,
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
                        bottomBarColor: Colors.transparent,
                        selectedColor: AppColors.primaryColor,
                        todayColor: AppColors.primaryColor,
                        // eventColor: AppColors.primaryColor,
                        // eventDoneColor: Colors.yellow,
                        dayOfWeekStyle:
                            TextStyle(color: AppColors.primaryColor),
                        bottomBarTextStyle: TextStyle(color: Colors.black),

                        events: event,
                        // isExpanded: true,
                        isExpandable: true,
                        hideArrows: false,
                        hideBottomBar: false,
                        weekDays: const [
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
