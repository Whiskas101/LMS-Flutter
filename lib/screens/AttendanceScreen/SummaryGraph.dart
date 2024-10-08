import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryGraph extends StatelessWidget {
  const SummaryGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(
              show: false,
            ),
            // alignment: BarChartAlignment.center,
            // groupsSpace: 20,
            borderData: FlBorderData(show: false),
            barGroups: [
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(
                    toY: 20, borderRadius: BorderRadius.circular(0), width: 25)
              ]),
              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 25)]),
              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 30)]),
              BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 35)]),
              BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 35)]),
            ],
          ),
        ),
      ),
    );
  }
}
