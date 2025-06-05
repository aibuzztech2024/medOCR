import 'package:avatar/models/chart/chart_data.dart';
import 'package:avatar/viewModels/chart/controller/chart_controller.dart';
import 'package:avatar/views/chart/widgets/chart_legend_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Widget for displaying a multiline chart with dynamic legends.
///
/// It uses FL Chart's LineChart widget and custom ChartLegendWidget to visualize
/// multiple data series which can be toggled individually.
///
/// The chart data must be provided via `ChartSeries`, and toggling visibility
/// updates the lines dynamically.
class MultiLineChartWidget extends StatelessWidget {
  /// List of chart series to display
  final List<ChartSeries> series;

  /// Height of the chart area
  final double height;

  const MultiLineChartWidget({
    super.key,
    required this.series,
    this.height = 184,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize controller using GetX
    final ChartController controller = Get.put(ChartController());

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Light yellow-orange background with semi-transparency
        color: const Color(0x0DF79E1B), // #F79E1B with ~5% opacity
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0x40CB7E40),
        ), // 25% opacity border
      ),
      child: Column(
        children: [
          // Line Chart Area
          SizedBox(
            height: height,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 50,
                  getDrawingHorizontalLine:
                      (value) => FlLine(color: Colors.black12, strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) return const Text('1 Apr');
                        if (value == 6) return const Text('30 Apr');
                        return const Text('');
                      },
                    ),
                  ),
                  // Hide right and top axis titles
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: _buildLineBarsData(),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 150,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Interactive legend to toggle chart series
          ChartLegendWidget(
            series: controller.chartSeries,
            onToggle: controller.toggleSeriesVisibility,
          ),
        ],
      ),
    );
  }

  /// Builds a list of LineChartBarData from the visible series only.
  List<LineChartBarData> _buildLineBarsData() {
    return series
        .where((s) => s.isVisible)
        .map(
          (chartSeries) => LineChartBarData(
            spots:
                chartSeries.data
                    .asMap()
                    .entries
                    .map(
                      (entry) =>
                          FlSpot(entry.key.toDouble(), entry.value.value),
                    )
                    .toList(),
            isCurved: true,
            color: chartSeries.color,
            barWidth: 2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 1,
                  strokeColor: chartSeries.color,
                );
              },
            ),
            belowBarData: BarAreaData(show: false),
          ),
        )
        .toList();
  }
}
