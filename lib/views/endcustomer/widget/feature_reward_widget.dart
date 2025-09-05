import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/endcustomer/controller/rewards_contoller.dart';
import 'package:avatar/views/endcustomer/widget/reward_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Widget to display a horizontally scrollable list of featured rewards.
/// Initially shows a loading spinner while data is fetched.
/// Includes a "View All" option for navigation to a full rewards list screen.
class FeatureRewardsWidget extends StatelessWidget {
  const FeatureRewardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ⏺️ Inject the controller (you may want to move this to a parent widget if reused elsewhere)
    final controller = Get.put(FeatureRewardsController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ⏺️ Header: "Feature Rewards" title and "View All" button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.heading('Feature Rewards', fontWeight: FontWeight.w700),

              // ⏺️ View All Action
              InkWell(
                onTap: () {
                  // TODO: Navigate to full rewards listing page
                  Get.snackbar('View All', 'Navigate to all rewards');
                },
                child: Row(
                  children: [
                    AppText.body(
                      'View All',
                      fontWeight: FontWeight.w600,
                      color: LightThemeColors.pharmacyColor,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: LightThemeColors.pharmacyColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ⏺️ Horizontal Scroll List of Reward Cards
        Obx(() {
          if (controller.isLoading.value) {
            // ⏳ Show loader while fetching rewards
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFF79E1B)),
            );
          }

          if (controller.rewards.isEmpty) {
            // 📭 Show message when no rewards are available
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('No featured rewards available.'),
              ),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children:
                  controller.rewards.map((reward) {
                    return RewardCard(
                      reward: reward,
                      onTap: () {
                        // TODO: Navigate to reward details page
                        controller.onRewardTap(reward);
                      },
                    );
                  }).toList(),
            ),
          );
        }),
      ],
    );
  }
}
