import 'package:avatar/models/chart/chart_data.dart';
import 'package:avatar/viewModels/chart/controller/chart_controller.dart';
import 'package:avatar/views/chart/widgets/multi_line_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Main screen displaying chart analytics with:
/// - AppBar including refresh action
/// - Line chart visualization with toggleable series
/// - Summary cards showing average and total values per series
class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ChartController using GetX dependency injection
    final ChartController controller = Get.put(ChartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        actions: [
          // Refresh button to reload/refresh the chart data
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshData,
          ),
        ],
      ),

      // Reactive body: Observes controller's isLoading and chartSeries changes
      body: Obx(() {
        if (controller.isLoading) {
          // Show loading indicator while data is being fetched
          return const Center(child: CircularProgressIndicator());
        }

        // Main content: scrollable with padding and column layout
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header for the overview section
              const Text(
                'Monthly Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 24),

              // Multi-line chart with toggleable data series
              MultiLineChartWidget(series: controller.chartSeries),

              const SizedBox(height: 24),

              // Summary cards showing average and total of each series
              _buildStatsCards(controller.chartSeries),
            ],
          ),
        );
      }),
    );
  }

  /// Builds a horizontal row of cards summarizing each chart series
  ///
  /// Shows:
  /// - Series name in its color
  /// - Average value of data points
  /// - Total sum of data points
  Widget _buildStatsCards(List<ChartSeries> series) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children:
              series.map((chartSeries) {
                // Calculate total and average for the current series
                double total = chartSeries.data.fold(
                  0,
                  (sum, data) => sum + data.value,
                );
                double average = total / chartSeries.data.length;

                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: chartSeries.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: chartSeries.color.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Series name styled with its color
                        Text(
                          chartSeries.name,
                          style: TextStyle(
                            color: chartSeries.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Average value display
                        Text(
                          'Avg: ${average.toInt()}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        // Total value display (smaller and greyed out)
                        Text(
                          'Total: ${total.toInt()}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
