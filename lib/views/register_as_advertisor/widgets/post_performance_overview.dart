import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/register_advisor/post_performance_controller.dart';
import 'package:avatar/views/register_as_advertisor/widgets/performance_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPerformanceOverview extends StatelessWidget {
  const PostPerformanceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(PostPerformanceController());

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.heading(
                'Post Performance Overview',
                fontWeight: FontWeight.w700,
              ),

              GestureDetector(
                onTap: () => controller.refreshData(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.tune, size: 20, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Performance Cards
          Obx(() {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              );
            }

            if (controller.error.isNotEmpty) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      controller.error,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => controller.refreshData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final data = controller.performanceData;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top row with two cards
                Row(
                  children: [
                    Expanded(
                      child: PerformanceCard(
                        title: 'Total Coupon',
                        value: data.totalCoupons.toString(),
                        subtitle: data.lastUpdated,
                        icon: Icons.copy_outlined,
                        backgroundColor: LightThemeColors.advertisorColor15,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PerformanceCard(
                        title: 'Total redemptions',
                        value: data.totalRedemptions.toString(),
                        subtitle: data.lastUpdated,
                        icon: Icons.visibility,
                        backgroundColor: LightThemeColors.advertisorColor15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Bottom row with single card
                Row(
                  children: [
                    Expanded(
                      child: PerformanceCard(
                        title: 'Active Coupons',
                        value: data.activeCoupons.toString(),
                        subtitle: data.lastUpdated,
                        icon: Icons.copy_outlined,
                        iconColor: LightThemeColors.advertisorColor15,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
