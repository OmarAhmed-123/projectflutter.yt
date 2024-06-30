import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoricalChart extends StatelessWidget {
  final Map<String, double> data;
  final String title;
  final Color color;

  const HistoricalChart(
      {super.key,
      required this.data,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = data.entries.map((entry) {
      DateTime date = DateTime.parse(entry.key);
      double x = date.millisecondsSinceEpoch.toDouble();
      return FlSpot(x, entry.value);
    }).toList();

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: (value, meta) {
                      DateTime date =
                          DateTime.fromMillisecondsSinceEpoch(value.toInt());
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text('${date.month}/${date.year}'),
                      );
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              minX: spots.first.x,
              maxX: spots.last.x,
              minY: data.values.reduce((a, b) => a < b ? a : b),
              maxY: data.values.reduce((a, b) => a > b ? a : b),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: color, // Use 'color' directly
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    show: true,
                    color:
                        color.withOpacity(0.3), // Use 'color.withOpacity(0.3)'
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
