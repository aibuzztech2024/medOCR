import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/views/advertisor/widget/line_chart_painter.dart'
    show LineChartPainter;
import 'package:flutter/material.dart';

// this is the points calculator card in points screen below the graph
class PointsOverviewCard extends StatelessWidget {
  final int totalPoints;
  final Map<String, int> pointsBreakdown;
  final bool showChart;

  const PointsOverviewCard({
    super.key,
    required this.totalPoints,
    required this.pointsBreakdown,
    this.showChart = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: LightThemeColors.scaffoldBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.heading('Points Overview'),
              Icon(Icons.tune, color: Colors.grey[600], size: 24),
            ],
          ),
          const SizedBox(height: 20),

          // container for total points and displaying the graph
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: AppText.heading('Total Points : $totalPoints')),
                if (showChart) ...[const SizedBox(height: 20), _buildChart()],
              ],
            ),
          ),

          const SizedBox(height: 20),
          _buildPointsBreakdown(),
        ],
      ),
    );
  }

  // displays the chart
  Widget _buildChart() {
    return SizedBox(
      height: 120,
      child: CustomPaint(
        painter: LineChartPainter(),
        size: const Size(double.infinity, 120),
      ),
    );
  }


  Widget _buildPointsBreakdown() {
    final totalSum = pointsBreakdown.values.fold(
      0,
      (sum, value) => sum + value,
    );

    return Column(
      children: [
        Container(
          color: LightThemeColors.inputFill,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.caption(
                  'Total\nPoints',
                  color: LightThemeColors.advertisorColor,
                  fontWeight: FontWeight.w600,
                ),
                AppText.body('$totalSum', fontWeight: FontWeight.w700),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              pointsBreakdown.entries
                  .map((entry) => _buildPointCategory(entry.key, entry.value))
                  .toList(),
        ),
      ],
    );
  }

  //points continer
  Widget _buildPointCategory(String title, int points) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: LightThemeColors.inputFill, 
        borderRadius: BorderRadius.circular(8), 
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            '$points',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
