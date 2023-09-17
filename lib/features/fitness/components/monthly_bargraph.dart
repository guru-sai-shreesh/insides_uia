import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../model/colors.dart';

class MonthlyBargraphComponent extends StatelessWidget {
  final double minY, maxY, height, width;
  final Map<DateTime, double> data;
  final Color color;
  const MonthlyBargraphComponent(
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
                        x: timeStamp.day,
                        barRods: [
                          BarChartRodData(
                              toY: averageHeartRate,
                              width: 8,
                              color: color,
                              borderRadius: BorderRadius.circular(2),
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
      fontSize: 8,
    );
    Widget text;
    text = Text(value.toStringAsFixed(0), style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }
}
