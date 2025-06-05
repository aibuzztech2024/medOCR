import 'package:avatar/models/chart/chart_data.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// Controller responsible for managing chart data and state
///
/// Uses GetX for reactive state management.
class ChartController extends GetxController {
  /// Observable list of chart series data
  final RxList<ChartSeries> _chartSeries = <ChartSeries>[].obs;

  /// Observable loading state
  final RxBool _isLoading = false.obs;

  /// Public getter for the chart series data
  List<ChartSeries> get chartSeries => _chartSeries;

  /// Public getter for loading status
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Load initial chart data when controller is initialized
    loadChartData();
  }

  /// Loads chart data from source (simulated here with delay)
  ///
  /// TODO: Replace with real API call to fetch backend data
  void loadChartData() {
    _isLoading.value = true;

    // Simulated network delay for loading data
    Future.delayed(const Duration(milliseconds: 500), () {
      _chartSeries.value = [
        ChartSeries(
          name: 'Bill',
          color: const Color(0xFF2196F3),
          data: _generateBillData(),
        ),
        ChartSeries(
          name: 'Purchases',
          color: const Color(0xFFFF9800),
          data: _generatePurchaseData(),
        ),
        ChartSeries(
          name: 'Points',
          color: const Color(0xFF009688),
          data: _generatePointsData(),
        ),
      ];
      _isLoading.value = false;
    });
  }

  /// Sample data generator for 'Bill' series
  List<ChartData> _generateBillData() {
    return [
      ChartData(date: DateTime(2024, 4, 1), value: 110),
      ChartData(date: DateTime(2024, 4, 5), value: 5),
      ChartData(date: DateTime(2024, 4, 10), value: 8),
      ChartData(date: DateTime(2024, 4, 15), value: 100),
      ChartData(date: DateTime(2024, 4, 20), value: 65),
      ChartData(date: DateTime(2024, 4, 25), value: 45),
      ChartData(date: DateTime(2024, 4, 30), value: 145),
    ];
  }

  /// Sample data generator for 'Purchases' series
  List<ChartData> _generatePurchaseData() {
    return [
      ChartData(date: DateTime(2024, 4, 1), value: 75),
      ChartData(date: DateTime(2024, 4, 5), value: 135),
      ChartData(date: DateTime(2024, 4, 10), value: 25),
      ChartData(date: DateTime(2024, 4, 15), value: 100),
      ChartData(date: DateTime(2024, 4, 20), value: 120),
      ChartData(date: DateTime(2024, 4, 25), value: 45),
      ChartData(date: DateTime(2024, 4, 30), value: 85),
    ];
  }

  /// Sample data generator for 'Points' series
  List<ChartData> _generatePointsData() {
    return [
      ChartData(date: DateTime(2024, 4, 1), value: 85),
      ChartData(date: DateTime(2024, 4, 5), value: 95),
      ChartData(date: DateTime(2024, 4, 10), value: 5),
      ChartData(date: DateTime(2024, 4, 15), value: 125),
      ChartData(date: DateTime(2024, 4, 20), value: 135),
      ChartData(date: DateTime(2024, 4, 25), value: 5),
      ChartData(date: DateTime(2024, 4, 30), value: 35),
    ];
  }

  /// Toggles visibility of a chart series by index
  ///
  /// Updates the observable list immutably to trigger UI updates.
  void toggleSeriesVisibility(int index) {
    if (index < _chartSeries.length) {
      _chartSeries[index] = _chartSeries[index].copyWith(
        isVisible: !_chartSeries[index].isVisible,
      );
    }
  }

  /// Refreshes chart data by reloading it
  ///
  /// Can be used on pull-to-refresh or refresh button tap.
  void refreshData() {
    loadChartData();
  }

  // TODO: Add error handling for API failures when integrated with backend
  // TODO: Add pagination or incremental loading if data grows large
  // TODO: Add caching mechanism to reduce redundant API calls
}
