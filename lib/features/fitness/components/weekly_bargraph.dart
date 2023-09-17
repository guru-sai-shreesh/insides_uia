import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../model/colors.dart';

class WeeklyBargraphComponent extends StatelessWidget {
  final double minY, maxY, height, width;
  final Map<DateTime, double> data;
  final Color color;
  const WeeklyBargraphComponent(
      {super.key,
      required this.minY,
      required this.maxY,
      required this.height,
      required this.width,
      required this.data,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          child: data.isNotEmpty
              ? BarChart(
                  BarChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: ((value, meta) {
                                return getTitles(value, meta);
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
                    minY: minY,
                    maxY: maxY,
                    barGroups: data.entries.map((entry) {
                      final timeStamp = entry.key;
                      final averageHeartRate = entry.value;

                      return BarChartGroupData(
                        x: timeStamp.weekday,
                        barRods: [
                          BarChartRodData(
                              toY: averageHeartRate,
                              width: 20,
                              color: color,
                              borderRadius: BorderRadius.circular(4),
                              backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: maxY,
                                  color: Color.fromARGB(255, 234, 234, 234))),
                        ],
                      );
                    }).toList(),
                  ),
                )
              : Center(child: Text("NO DATA")),
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var style = const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
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
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }
}
