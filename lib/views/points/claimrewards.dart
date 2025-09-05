import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/custum_searchbar.dart';
import 'package:avatar/viewModels/points/claimrewards_viewmodel.dart';
import 'package:avatar/views/points/widget/rewards_claimed.dart';

class Claimrewards extends StatelessWidget {
  Claimrewards({super.key});

  // Initialize your controller using Get.put or Get.find
  final ClaimRewardsViewModel viewModel = Get.put(ClaimRewardsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CustomSearchBar(),
            const SizedBox(height: 10),

            Expanded(
              child: Obx(() {
                final rewards = viewModel.rewards;
                if (rewards.isEmpty) {
                  return const Center(child: Text('No claimed rewards yet.'));
                }
                return ListView.builder(
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    return RewardsClaimed(reward: rewards[index],color: LightThemeColors.pharmacyColor,);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
