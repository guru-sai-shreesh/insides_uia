import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/features/fitness/components/fitness_card.dart';
import 'package:insides/features/fitness/services/local/fitness_shared_prefs.dart';
import 'package:insides/features/fitness/views/health_insights.dart';
import 'package:insides/model/colors.dart';
import 'package:insides/features/fitness/components/circular_progress_indicator.dart';

import '../model/health_data.dart';
import '../services/remote/fetch_health_data.dart';
import '../state/fitness_state.dart';

class Fitness extends ConsumerStatefulWidget {
  const Fitness({Key? key}) : super(key: key);

  @override
  ConsumerState<Fitness> createState() => _FitnessState();
}

int count = 0;

class _FitnessState extends ConsumerState<Fitness> {
  late Timer _timer;
  bool isDataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Start the timer to fetch data periodically.
    _fetchData(ref);
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      _fetchData(ref);
    });
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks.
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchData(ref) async {
    try {
      // Fetch health data
      final height = await FetchHealthData().fetchHeight();
      final weight = await FetchHealthData().fetchWeight();
      final heartRate = await FetchHealthData().fetchHR();
      final wSteps = await FetchHealthData().fetchWNoStep();
      final steps = await FetchHealthData().fetchNoStep();
      final bpSystolic = await FetchHealthData().bloodPreasureSystolic();
      final bpDiastolic = await FetchHealthData().bloodPreasureDiastolic();

      final newHealthData = HealthDataModel(
        height: height == null
            ? "--"
            : double.parse(height.value.toString()).toStringAsFixed(2),
        weight: weight == null
            ? "--"
            : double.parse(weight.value.toString()).toStringAsFixed(2),
        heartRate: heartRate == null ? "--" : heartRate.value.toString(),
        steps: steps == null ? "--" : steps.toString(),
        bloodPressureSystolic: bpSystolic == null
            ? "--"
            : double.parse(bpSystolic.value.toString()).toStringAsFixed(0),
        bloodPressureDiastolic: bpDiastolic == null
            ? "--"
            : double.parse(bpDiastolic.value.toString()).toStringAsFixed(0),
        wSteps: wSteps == null ? "--" : wSteps.toString(),
        timeStamp: DateTime.now(),
      );

      // Update the healthData using the provider
      ref.read(healthDataProvider.notifier).state = newHealthData;
      // Cache the health data
      await FitnessSharedPreferences.cacheHealthData(newHealthData);

      // Set the flag to true when data is loaded
      setState(() {
        isDataLoaded = true;
      });
    } catch (e) {
      // Handle errors gracefully, log or display error messages.
      print('Error fetching health data: $e');

      // Use cached data when internet is not available
      final cachedData = await FitnessSharedPreferences.getCachedHealthData();
      if (cachedData != null) {
        ref.read(healthDataProvider.notifier).state = cachedData;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final healthData = ref.watch(healthDataProvider);
    print(healthData.height);

    return Container(
        color: Colors.white,
        child: isDataLoaded
            ? Scaffold(
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
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications_outlined)),
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
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.centerLeft,
                            child: RadialProgressComponent(
                              progress: healthData.steps != "--"
                                  ? double.parse(healthData.steps) / 600
                                  : 0,
                              primaryText: healthData.steps != "--"
                                  ? double.parse(healthData.steps)
                                          .toInt()
                                          .toString() +
                                      "/" +
                                      600.toString()
                                  : 0.toString() + "/" + 600.toString(),
                              color: AppColors.cardcolor,
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.4,
                              secondaryText: 'Steps Walked',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15),
                            child: Text(
                              "ACTIVITY",
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          FitnessCardComponent(
                            cardColor: AppColors.cardcolor,
                            cardTitle: "Steps Count",
                            cardData: healthData.wSteps.toString(),
                            progress: (healthData.wSteps != "--"
                                    ? double.parse(healthData.wSteps).toInt()
                                    : 0) /
                                1000,
                            cardSecondaryData: "Steps",
                            cardDescription: "Last 7 days",
                            dateTime: healthData.timeStamp,
                            cardIcon: Icons.run_circle_rounded,
                            page: FitnessInsightsScreen(
                              healthInsightType: HealthInsightType.steps,
                              title: "Walking",
                              weeklyFetchFunction:
                                  FetchHealthData().fetchWeeklyStepsData,
                              monthlyFetchFunction:
                                  FetchHealthData().fetchMonthlyHeartRateData,
                            ),
                          ),
                          FitnessCardComponent(
                            cardColor: AppColors.cardcolor,
                            cardTitle: "Calories Burned",
                            cardData: "280",
                            cardSecondaryData: "CAL",
                            cardDescription: "Today",
                            dateTime: healthData.timeStamp,
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
                          FitnessCardComponent(
                            cardColor: AppColors.cardcolor,
                            cardTitle: "Heart Rate",
                            cardData: healthData.heartRate,
                            cardSecondaryData: "BPM",
                            cardDescription: "Normal",
                            cardIcon: Icons.favorite,
                            dateTime: healthData.timeStamp,
                            page: FitnessInsightsScreen(
                              healthInsightType: HealthInsightType.heartRate,
                              title: "Heart Rate",
                              weeklyFetchFunction:
                                  FetchHealthData().fetchWeeklyHeartRateData,
                              monthlyFetchFunction:
                                  FetchHealthData().fetchMonthlyHeartRateData,
                            ),
                          ),
                          FitnessCardComponent(
                            cardColor: AppColors.cardcolor,
                            cardTitle: "Blood Presure",
                            cardData:
                                "${healthData.bloodPressureSystolic}/${healthData.bloodPressureDiastolic}",
                            cardDescription: "Normal",
                            dateTime: healthData.timeStamp,
                            page: FitnessInsightsScreen(
                              healthInsightType:
                                  HealthInsightType.bloodPreasure,
                              title: "Blood Presure",
                              weeklyFetchFunction:
                                  FetchHealthData().fetchWeeklyBPSystolic,
                              weeklyFetchFunction2:
                                  FetchHealthData().fetchWeeklyBPDiastolic,
                              monthlyFetchFunction:
                                  FetchHealthData().fetchWeeklyBPSystolic,
                              monthlyFetchFunction2:
                                  FetchHealthData().fetchMonthlyBPDiastolic,
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
                          FitnessCardComponent(
                            cardColor: AppColors.cardcolor,
                            cardTitle: "BMI",
                            cardData: (healthData.height != "--" ||
                                    healthData.weight != "--")
                                ? (double.parse(healthData.weight) /
                                        double.parse(healthData.height))
                                    .toStringAsFixed(2)
                                : "--",
                            cardDescription: "Normal",
                            dateTime: healthData.timeStamp,
                          ),
                          FitnessCardComponent(
                            cardColor: AppColors.cardcolor,
                            cardTitle: "Height",
                            cardData: healthData.height != "--"
                                ? (double.parse(healthData.height) *
                                        100 /
                                        30.48)
                                    .floor()
                                    .toString()
                                : "--",
                            cardSecondaryData: "ft ",
                            cardData2: healthData.height != "--"
                                ? (((double.parse(healthData.height) *
                                                100 /
                                                30.48) -
                                            (double.parse(healthData.height) *
                                                    100 /
                                                    30.48)
                                                .floor()) *
                                        10)
                                    .toStringAsFixed(0)
                                : "--",
                            cardSecondaryData2: "in",
                            dateTime: healthData.timeStamp,
                          ),
                          FitnessCardComponent(
                            cardColor: AppColors.cardcolor,
                            cardTitle: "Weight",
                            cardData: healthData.weight,
                            cardSecondaryData: "Kg",
                            dateTime: healthData.timeStamp,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
