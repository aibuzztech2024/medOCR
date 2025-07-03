import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../viewModels/hospital/donut_chart_controller.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/themes/light/light_theme_colors.dart';

class DonutChartWidget extends StatelessWidget {
  final DonutChartController controller = Get.put(DonutChartController());

  DonutChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final dataMap = {
        for (var item in controller.chartData)
          item.category: item.points.toDouble(),
      };

      final colorList = controller.chartData.map((e) => e.color).toList();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Donut chart
              PieChart(
                dataMap: dataMap,
                chartType: ChartType.ring,
                chartRadius: 80,
                ringStrokeWidth: 20,
                colorList: colorList,
                legendOptions: const LegendOptions(showLegends: false),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValues: false,
                ),
              ),

              const SizedBox(width: 24),

              // Legend
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    controller.chartData.map((data) {
                      int index = controller.chartData.indexOf(data);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: data.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 100, // fixed label width
                              child: AppText(
                                data.category,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: LightThemeColors.titleText,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 40, // fixed width for right-aligned points
                              child: AppText(
                                "${data.points}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: LightThemeColors.titleText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Total Points Box
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      color: LightThemeColors.primary,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    AppText(
                      "Total Points",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: LightThemeColors.titleText,
                      ),
                    ),
                  ],
                ),
                AppText(
                  "${controller.totalPoints.value}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: LightThemeColors.titleText,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
