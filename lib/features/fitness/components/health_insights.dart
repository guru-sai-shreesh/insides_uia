import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:insides/model/colors.dart';

enum HealthPeriod { today, weekly, monthly }

class FitnessInsightsScreen extends StatefulWidget {
  final String title;
  final Function todayFetchFunction;
  final Function weeklyFetchFunction;
  final Function monthlyFetchFunction;

  const FitnessInsightsScreen(
      {super.key,
      required this.title,
      required this.todayFetchFunction,
      required this.weeklyFetchFunction,
      required this.monthlyFetchFunction});

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
                      _buildChart(),
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
        _buildPeriodButton('Today', HealthPeriod.today),
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

  Widget _buildChart() {
    return FutureBuilder(
      future: fetchHealthData(_selectedPeriod),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching data.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available for the selected period.');
        } else {
          // Calculate daily average heart rates
          Map<DateTime, double> dailyAverages = calculateDailyAverages(
              snapshot.data as List<HealthDataPoint>, _selectedPeriod);

          // Convert daily averages to bar chart data
          List<BarChartGroupData> barChartGroups =
              dailyAverages.entries.map((entry) {
            final timeStamp = entry.key;
            final averageHeartRate = entry.value;

            return BarChartGroupData(
              x: _selectedPeriod == HealthPeriod.weekly
                  ? timeStamp.weekday
                  : timeStamp.day,
              barRods: [
                BarChartRodData(
                    toY: averageHeartRate,
                    width: _selectedPeriod == HealthPeriod.weekly ? 20 : 10,
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(
                        _selectedPeriod == HealthPeriod.weekly ? 4 : 2),
                    backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: _getMaxAveragehealthData(dailyAverages),
                        color: Color.fromARGB(255, 234, 234, 234))),
              ],
            );
          }).toList();

          return Container(
            height: 250,
            width: MediaQuery.of(context).size.width * 0.9,
            child: dailyAverages.isNotEmpty
                ? BarChart(
                    BarChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: ((value, meta) {
                                  return getTitles(
                                      value, meta, _selectedPeriod);
                                }))),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.white, width: 0),
                      ),
                      minY: 0,
                      maxY: _getMaxAveragehealthData(dailyAverages) + 20,
                      barGroups: barChartGroups,
                    ),
                  )
                : Center(child: Text("NO {$_selectedPeriod} DATA")),
          );
        }
      },
    );
  }

  Widget getTitles(double value, TitleMeta meta, HealthPeriod selectedPeriod) {
    var style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: (selectedPeriod == HealthPeriod.weekly) ? 14 : 10,
    );
    Widget text;
    if (selectedPeriod == HealthPeriod.weekly) {
      switch (value.toInt()) {
        case 1:
          text = Text('M', style: style);
          break;
        case 2:
          text = Text('T', style: style);
          break;
        case 3:
          text = Text('W', style: style);
          break;
        case 4:
          text = Text('T', style: style);
          break;
        case 5:
          text = Text('F', style: style);
          break;
        case 6:
          text = Text('S', style: style);
          break;
        case 7:
          text = Text('S', style: style);
          break;
        default:
          text = Text('--', style: style);
          break;
      }
    } else {
      text = Text(value.toStringAsFixed(0), style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    if (value % 1 != 0) {
      return Container();
    }
    final style = TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: min(18, 18 * chartWidth / 300),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(meta.formattedValue, style: style),
    );
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

      print(averageHealthDatas);
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
    } else if (period == HealthPeriod.monthly) {
      Map<DateTime, List<double>> dailyAverages = {};
      Map<DateTime, double> averageHealthDatas = {};
      final today = DateTime.now();
      final lastMonth = today.subtract(Duration(days: today.day));

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
      print(averageHealthDatas);
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
      final today = DateTime.now();
      final lastMonth = today.subtract(Duration(days: today.day));

      // Iterate over the days from today to last month
      DateTime currentDate = today;
      // while (currentDate.isAfter(lastMonth)) {
      //   dailyAverages[DateTime(
      //       currentDate.year, currentDate.month, currentDate.day)] = [];
      //   currentDate = currentDate.subtract(Duration(days: 1));
      // }

      for (HealthDataPoint dataPoint in data) {
        final timestamp = dataPoint.dateFrom;
        final healthData = double.parse(dataPoint.value.toString());
        dailyAverages[DateTime(timestamp.year, timestamp.month, timestamp.day)]!
            .add(healthData);
      }
      Map<DateTime, double> averageHealthData = {};
      print(averageHealthData);
      dailyAverages.forEach((day, healthDatas) {
        if (healthDatas == []) {
          averageHealthData[day] = 0;
        } else {
          final sum = healthDatas.reduce((a, b) => a + b);
          final average = sum / healthDatas.length;
          averageHealthData[day] = average;
        }
      });
      return reverseOrder(averageHealthData);
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
      case HealthPeriod.today:
        healthData =
            (await widget.todayFetchFunction()) as List<HealthDataPoint>;
        break;
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

  Map<DateTime, double> reverseOrder(Map<DateTime, double> inputMap) {
    List<MapEntry<DateTime, double>> entries = inputMap.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key));
    Map<DateTime, double> reversedMap = Map.fromEntries(entries);

    return reversedMap;
  }
}
