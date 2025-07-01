import 'package:flutter/material.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/views/points/widget/reward_card.widget.dart';
import 'package:avatar/views/points/widget/allrewards_tabbar.dart';
import 'package:avatar/viewModels/points/allrewards_viewmodel.dart';
import 'package:get/utils.dart';

/// Main screen for displaying rewards with tabbed sections for featured rewards and popular coupons.
/// TODO: Connect this viewModel to backend API to fetch live rewards data.
class Allrewards extends StatelessWidget {
  const Allrewards({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = AllRewardsViewModel();

    // TODO: Replace with reactive API data fetch, and possibly bind with GetX controller
    final featuredRewards = viewModel.featuredRewards;
    final popularCoupons = viewModel.popularCoupons;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: AllrewardsTabbar(
        tabTitles: viewModel.tabTitles,
        backgroundColor: LightThemeColors.inputFill,
        tabContents: [
          // Featured Rewards tab content
          ListView.builder(
            itemCount: featuredRewards.length,
            itemBuilder: (context, index) {
              return RewardCardWidget(
                reward: featuredRewards[index],
                color: LightThemeColors.pharmacyColor,
                colors: LightThemeColors.secondarypharmacyColor,
              );
            },
          ),

          // Popular Coupons tab content
          ListView.builder(
            itemCount: popularCoupons.length,
            itemBuilder: (context, index) {
              return RewardCardWidget(
                reward: popularCoupons[index],
                isPopularcoupon: true,
                color: LightThemeColors.pharmacyColor,
                colors: LightThemeColors.secondarypharmacyColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
