import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/models/chart/chart_data.dart';
import 'package:flutter/material.dart';

/// A widget that displays a row of toggleable legend items for a chart.
///
/// Each legend item includes:
/// - A checkbox to show/hide the corresponding chart data series
/// - A color dot representing the series color
/// - The name of the series
///
/// Used in conjunction with charts where multiple data series can be toggled.
class ChartLegendWidget extends StatelessWidget {
  /// List of chart series (data) to display as legend items.
  final List<ChartSeries> series;

  /// Callback function triggered when a legend item is toggled.
  /// It provides the index of the toggled item.
  final Function(int) onToggle;

  const ChartLegendWidget({
    super.key,
    required this.series,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          series.asMap().entries.map((entry) {
            final index = entry.key;
            final chartSeries = entry.value;

            return GestureDetector(
              onTap: () => onToggle(index),
              child: Row(
                children: [
                  // Checkbox to toggle series visibility
                  Icon(
                    chartSeries.isVisible
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color:
                        chartSeries.isVisible
                            ? const Color(0xFF1E4D92)
                            : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 6),

                  // Colored dot representing series color
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: chartSeries.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Series name with different color based on visibility
                  AppText.caption(
                    chartSeries.name,
                    color: chartSeries.isVisible ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
