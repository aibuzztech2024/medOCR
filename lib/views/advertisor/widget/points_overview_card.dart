import 'package:avatar/views/advertisor/widget/line_chart_painter.dart' show LineChartPainter;
import 'package:flutter/material.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Points Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Icon(Icons.tune, color: Colors.grey[600], size: 20),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Total Points : $totalPoints',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          if (showChart) ...[
            const SizedBox(height: 20),
            _buildChart(),
          ],
          const SizedBox(height: 20),
          _buildPointsBreakdown(),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return Container(
      height: 120,
      child: CustomPaint(
        painter: LineChartPainter(),
        size: const Size(double.infinity, 120),
      ),
    );
  }

  Widget _buildPointsBreakdown() {
    final totalSum = pointsBreakdown.values.fold(0, (sum, value) => sum + value);
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total\nPoints',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red[400],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$totalSum',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: pointsBreakdown.entries
              .map((entry) => _buildPointCategory(entry.key, entry.value))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPointCategory(String title, int points) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          '$points',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}