import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:insides/features/fitness/components/monthly_bargraph.dart';
import 'package:insides/model/colors.dart';
import '../components/steps_insights_card.dart';
import '../components/weekly_bargraph.dart';

enum HealthPeriod { weekly, monthly }

enum HealthInsightType { steps, heartRate, bloodPreasure }

class FitnessInsightsScreen extends StatefulWidget {
  final String title;
  final Function weeklyFetchFunction;
  final Function monthlyFetchFunction;
  final Function? weeklyFetchFunction2;
  final Function? monthlyFetchFunction2;
  final HealthInsightType healthInsightType;

  const FitnessInsightsScreen(
      {super.key,
      required this.title,
      required this.weeklyFetchFunction,
      required this.monthlyFetchFunction,
      required this.healthInsightType,
      this.weeklyFetchFunction2,
      this.monthlyFetchFunction2});

  @override
  _FitnessInsightsScreenState createState() => _FitnessInsightsScreenState();
}

class _FitnessInsightsScreenState extends State<FitnessInsightsScreen> {
  HealthPeriod _selectedPeriod = HealthPeriod.weekly;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            pinned: true,
            expandedHeight: 120,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final appBarHeight = constraints.maxHeight;
                // Calculate padding based on the appBarHeight
                const minPadding = EdgeInsets.only(left: 0, bottom: 15);
                const maxPadding = EdgeInsets.only(left: 50, bottom: 15);
                final padding = EdgeInsets.lerp(minPadding, maxPadding,
                    (120 - kToolbarHeight) / (appBarHeight - kToolbarHeight));

                return FlexibleSpaceBar(
                  titlePadding: padding,
                  centerTitle: false,
                  expandedTitleScale: 1.4,
                  title: Text(
                    "${widget.title} Insights",
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _buildPeriodSelector(),
                      _buildInsights(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPeriodButton('Weekly', HealthPeriod.weekly),
        _buildPeriodButton('Monthly', HealthPeriod.monthly),
      ],
    );
  }

  Widget _buildPeriodButton(String text, HealthPeriod period) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedPeriod = period;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: _selectedPeriod == period ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  Widget _buildInsights() {
    return FutureBuilder(
      future: widget.healthInsightType == HealthInsightType.bloodPreasure
          ? fetchBP(_selectedPeriod)
          : fetchHealthData(_selectedPeriod),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching data.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available for the selected period.');
        } else {
          // Calculate daily average heart rates
          Map<DateTime, double> dailyAverages, dailyAverages2 = {};
          if (widget.healthInsightType == HealthInsightType.bloodPreasure) {
            Map<int, List<HealthDataPoint>> data =
                snapshot.data as Map<int, List<HealthDataPoint>>;
            dailyAverages = calculateDailyAverages(
                data[0] as List<HealthDataPoint>, _selectedPeriod);
            dailyAverages2 = calculateDailyAverages(
                data[1] as List<HealthDataPoint>, _selectedPeriod);
          } else {
            dailyAverages = calculateDailyAverages(
                snapshot.data as List<HealthDataPoint>, _selectedPeriod);
          }
          double totalSteps = 0;
          if (widget.healthInsightType == HealthInsightType.steps) {
            for (HealthDataPoint element
                in snapshot.data as List<HealthDataPoint>) {
              totalSteps += double.parse(element.value.toString());
            }
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: displayInsights(context, widget.healthInsightType,
                _selectedPeriod, totalSteps, dailyAverages, dailyAverages2),
          );
        }
      },
    );
  }

  Widget displayInsights(
    BuildContext context,
    HealthInsightType hit,
    HealthPeriod selectedPeriod,
    double totalSteps,
    Map<DateTime, double> dailyAverages,
    Map<DateTime, double> dailyAverages2,
  ) {
    switch (hit) {
      case HealthInsightType.steps:
        if (selectedPeriod == HealthPeriod.weekly) {
          return Column(
            children: [
              WeeklyBargraphComponent(
                minY: 0,
                maxY: _getMaxAveragehealthData(dailyAverages),
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                data: dailyAverages,
                color: AppColors.primaryColor,
              ),
              StepsInsightsCardComponent(
                  totalSteps: totalSteps,
                  goal: 18000,
                  calories: 3702,
                  nAchieved: 19)
            ],
          );
        } else {
          return Column(
            children: [
              MonthlyBargraphComponent(
                minY: 0,
                maxY: _getMaxAveragehealthData(dailyAverages),
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                data: dailyAverages,
                color: AppColors.primaryColor,
              ),
              StepsInsightsCardComponent(
                  totalSteps: totalSteps,
                  goal: 18000,
                  calories: 3702,
                  nAchieved: 19)
            ],
          );
        }
      case HealthInsightType.heartRate:
        if (selectedPeriod == HealthPeriod.weekly) {
          return Column(
            children: [
              WeeklyBargraphComponent(
                minY: 0,
                maxY: _getMaxAveragehealthData(dailyAverages),
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                data: dailyAverages,
                color: AppColors.primaryColor,
              ),
            ],
          );
        } else {
          return Column(
            children: [
              MonthlyBargraphComponent(
                minY: 0,
                maxY: _getMaxAveragehealthData(dailyAverages),
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                data: dailyAverages,
                color: AppColors.primaryColor,
              ),
            ],
          );
        }
      case HealthInsightType.bloodPreasure:
        if (selectedPeriod == HealthPeriod.weekly) {
          return Column(
            children: [
              Column(
                children: [
                  WeeklyBargraphComponent(
                    minY: 0,
                    maxY: _getMaxAveragehealthData(dailyAverages),
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.8,
                    data: dailyAverages,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  WeeklyBargraphComponent(
                    minY: 0,
                    maxY: _getMaxAveragehealthData(dailyAverages2),
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.8,
                    data: dailyAverages,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Column(
                children: [
                  MonthlyBargraphComponent(
                    minY: 0,
                    maxY: _getMaxAveragehealthData(dailyAverages),
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.9,
                    data: dailyAverages,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MonthlyBargraphComponent(
                    minY: 0,
                    maxY: _getMaxAveragehealthData(dailyAverages2),
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.9,
                    data: dailyAverages,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ],
          );
        }
    }
  }

  Map<DateTime, double> calculateDailyAverages(
      List<HealthDataPoint> data, HealthPeriod period) {
    if (period == HealthPeriod.weekly) {
      Map<DateTime, double> averageHealthDatas = {};
      Map<DateTime, List<double>> dailyAverages = {};
      DateTime currentDate = DateTime.now();

      for (int i = 0; i < 7; i++) {
        averageHealthDatas[
            DateTime(currentDate.year, currentDate.month, currentDate.day)] = 0;
        currentDate = currentDate.subtract(Duration(days: 1));
      }

      for (HealthDataPoint dataPoint in data) {
        final timestamp = dataPoint.dateFrom;
        final heartRate = double.parse(dataPoint.value.toString());
        if (dailyAverages.containsKey(
            DateTime(timestamp.year, timestamp.month, timestamp.day))) {
          dailyAverages[
                  DateTime(timestamp.year, timestamp.month, timestamp.day)]!
              .add(heartRate);
        } else {
          dailyAverages[DateTime(
              timestamp.year, timestamp.month, timestamp.day)] = [heartRate];
        }
      }

      dailyAverages.forEach((day, healthDatas) {
        if (healthDatas == []) {
          averageHealthDatas[day] = 0;
        } else {
          final sum = healthDatas.reduce((a, b) => a + b);
          final average = sum / healthDatas.length;
          averageHealthDatas[day] = average;
        }
      });
      return reverseOrder(averageHealthDatas);
    } else {
      Map<DateTime, List<double>> dailyAverages = {};
      Map<DateTime, double> averageHealthDatas = {};
      final today = DateTime.now();
      final lastMonth = today.subtract(Duration(days: 30));

      DateTime currentDate = today;
      while (currentDate.isAfter(lastMonth)) {
        averageHealthDatas[
            DateTime(currentDate.year, currentDate.month, currentDate.day)] = 0;
        currentDate = currentDate.subtract(Duration(days: 1));
      }

      for (HealthDataPoint dataPoint in data) {
        final timestamp = dataPoint.dateFrom;
        final healthData = double.parse(dataPoint.value.toString());
        if (dailyAverages.containsKey(
            DateTime(timestamp.year, timestamp.month, timestamp.day))) {
          dailyAverages[
                  DateTime(timestamp.year, timestamp.month, timestamp.day)]!
              .add(healthData);
        } else {
          dailyAverages[DateTime(
              timestamp.year, timestamp.month, timestamp.day)] = [healthData];
        }
      }

      dailyAverages.forEach((day, healthDatas) {
        if (healthDatas == []) {
          averageHealthDatas[day] = 0;
        } else {
          final sum = healthDatas.reduce((a, b) => a + b);
          final average = sum / healthDatas.length;
          averageHealthDatas[day] = average;
        }
      });
      return reverseOrder(averageHealthDatas);
    }
  }

  double _getMaxAveragehealthData(Map<DateTime, double> data) {
    // Find the maximum daily average heart rate
    double max = 0;
    data.forEach((ts, value) {
      if (value > max) {
        max = value;
      }
    });
    return max;
  }

  Future<List<HealthDataPoint>> fetchHealthData(HealthPeriod period) async {
    // Create an empty list to store health data
    List<HealthDataPoint> healthData = [];

    // Depending on the selected period, fetch the corresponding data
    switch (period) {
      case HealthPeriod.weekly:
        healthData =
            (await widget.weeklyFetchFunction()) as List<HealthDataPoint>;
        break;
      case HealthPeriod.monthly:
        healthData =
            (await widget.monthlyFetchFunction()) as List<HealthDataPoint>;
        break;
    }

    return healthData;
  }

  Future<Map<int, List<HealthDataPoint>>> fetchBP(HealthPeriod period) async {
    // Create an empty list to store health data
    Map<int, List<HealthDataPoint>> healthData = {0: [], 1: []};
    // Depending on the selected period, fetch the corresponding data
    switch (period) {
      case HealthPeriod.weekly:
        healthData[0] =
            (await widget.weeklyFetchFunction()) as List<HealthDataPoint>;
        healthData[1] =
            (await widget.monthlyFetchFunction()) as List<HealthDataPoint>;
        break;
      case HealthPeriod.monthly:
        healthData[0] =
            (await widget.weeklyFetchFunction2!()) as List<HealthDataPoint>;
        healthData[1] =
            (await widget.monthlyFetchFunction2!()) as List<HealthDataPoint>;
        break;
    }

    return healthData;
  }

  Map<DateTime, double> reverseOrder(Map<DateTime, double> inputMap) {
    List<MapEntry<DateTime, double>> entries = inputMap.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key));
    Map<DateTime, double> reversedMap = Map.fromEntries(entries);

    return reversedMap;
  }
}
