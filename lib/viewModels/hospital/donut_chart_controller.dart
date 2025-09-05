import 'package:get/get.dart';
import '../../core/widgets/chart_data_model.dart';

import 'package:flutter/material.dart';

class DonutChartController extends GetxController {
  var chartData = <ChartDataModel>[].obs;
  var totalPoints = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChartData();
  }

  void fetchChartData() async {
    // Simulate backend call
    await Future.delayed(const Duration(seconds: 1));

    final data = [
      ChartDataModel(category: 'Referral', points: 100, color: const Color(0xFF0F1C2F)),
      ChartDataModel(category: 'Map', points: 100, color: const Color(0xFFFFA726)),
      ChartDataModel(category: 'Subscription', points: 100, color: const Color(0xFF7C4DFF)),
      ChartDataModel(category: 'Donation', points: 100, color: const Color(0xFFFF6F61)),
    ];

    chartData.assignAll(data);
    totalPoints.value = data.fold(0, (sum, e) => sum + e.points);
  }
}
