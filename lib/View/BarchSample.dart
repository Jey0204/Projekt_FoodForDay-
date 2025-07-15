import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class BarChartSample extends StatelessWidget {
  final List<int> quantityData;
  final List<double> costData;
  final List<double> profitData;
  final List<String> labels;

  const BarChartSample({
    required this.quantityData,
    required this.costData,
    required this.profitData,
    required this.labels,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(
          quantityData.length,
          (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: costData[i].toDouble(),
                color: Colors.red,
                width: 6,
              ),
              BarChartRodData(
                toY: profitData[i].toDouble(),
                color: Colors.green,
                width: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarChartOne extends StatelessWidget {
  final List<int> quantityData;
  final List<double> costData;
  final List<double> profitData;
  final List<String> labels;

  const BarChartOne({
    required this.quantityData,
    required this.costData,
    required this.profitData,
    required this.labels,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(
          quantityData.length,
          (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: quantityData[i].toDouble(),
                color: Colors.blue,
                width: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
